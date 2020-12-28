#!/bin/bash

# Source the original entry point file to use its util functions.
. /usr/local/bin/docker-entrypoint.sh

# Check/set master options.
if [ -z "$MYSQL_MASTER_HOST" ]; then
  mysql_error "Missing \$MYSQL_MASTER_HOST"
fi
if [ -z "$MYSQL_MASTER_PORT" ]; then
  declare -igx MYSQL_MASTER_PORT=3306
fi
if [ -z "$MYSQL_MASTER_USER" ]; then
  mysql_error "Missing \$MYSQL_MASTER_USER"
fi
if [ -z "$MYSQL_MASTER_PASSWORD" ]; then
  mysql_error "Missing \$MYSQL_MASTER_PASSWORD"
fi

master_dump_done_file=/docker-entrypoint-initdb.d/.000-master-dump.done
master_dump_sql_file=/docker-entrypoint-initdb.d/000-master-dump.sql
repl_setup_sql_file=/docker-entrypoint-initdb.d/001-repl-setup.sql

master_exec_sql() {
  mysql --batch --skip-column-names \
    --host=$MYSQL_MASTER_HOST \
    --port=$MYSQL_MASTER_PORT \
    --user=$MYSQL_MASTER_USER \
    --password=$MYSQL_MASTER_PASSWORD \
    -e "$1"
  return $?
}

# ref:
# - http://ronaldbradford.com/blog/i-want-a-mysqldump-ignore-database-option-2012-04-18/
# - https://serversforhackers.com/c/mysqldump-with-modern-mysql
master_dump() {
  if [ -f $master_dump_done_file ]; then
    mysql_note "No need to dump master"
    return 0
  fi
  mysql_note "Master: $MYSQL_MASTER_USER@$MYSQL_MASTER_HOST:$MYSQL_MASTER_PORT"

  # Check gtid mode.
  declare gtidMode
  gtidMode=$(master_exec_sql "SELECT @@GTID_MODE") || exit $?
  if [ $gtidMode != 'ON' ]; then
    mysql_error "GTID mode is not 'ON' for master"
  fi

  # Get non system databases names.
  declare databases
  databases=$(master_exec_sql "SELECT IFNULL(GROUP_CONCAT(schema_name SEPARATOR ' '), '') 
      FROM information_schema.schemata 
      WHERE schema_name NOT IN ('mysql', 'information_schema', 'performance_schema', 'sys')") || exit $?
  if [ -z "$databases" ]; then
    mysql_error "No database found on master, please at least create one"
  fi
  mysql_note "Master databases to be dumped: $databases"

  # Dump!
  mysqldump --host=$MYSQL_MASTER_HOST --port=$MYSQL_MASTER_PORT --user=$MYSQL_MASTER_USER --password=$MYSQL_MASTER_PASSWORD \
    --databases $databases --set-gtid-purged=on --single-transaction --skip-lock-tables > $master_dump_sql_file || exit $?
  touch $master_dump_done_file
  mysql_note "Master dump is finished"
}

repl_setup() {
  if [ -f $repl_setup_sql_file ]; then
    return 0
  fi
  echo "CHANGE MASTER TO MASTER_HOST='$MYSQL_MASTER_HOST',
    MASTER_PORT=$MYSQL_MASTER_PORT,
    MASTER_USER='$MYSQL_MASTER_USER',
    MASTER_PASSWORD='$MYSQL_MASTER_PASSWORD',
    MASTER_AUTO_POSITION=1;
START SLAVE;" > $repl_setup_sql_file
}

# Dump master if not exists.
master_dump

# Setup slave.
repl_setup

# Enforce gtid mode enabled.
set -- "$@" --relay-log=repl-relay --gtid-mode=ON --enforce-gtid-consistency=ON

# Run the original main.
_main "$@"
