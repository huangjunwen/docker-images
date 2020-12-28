### MySQL 8 GTID replicator

This image runs a MySQL 8 replicator (both master/replicator must set `gtid_mode=on`), work flow:

- Make a full dump (`mysqldump`) from master into `/docker-entrypoint-initdb.d/000-master-dump.sql` if not exists.
- Write replication setup statement (`change master to ...`) into `/docker-entrypoint-initdb.d/001-repl-setup.sql` if no exists.
- Then start standard MySQL server which will load SQL files created above if the first time running.
  Which will load the full dump then start syncing.

How to:
  - Provide extra enviroments: 
    - `MYSQL_MASTER_HOST`: the host name of master.
    - `MYSQL_MASTER_PORT`: master port, default to 3306.
    - `MYSQL_MASTER_USER`: master user to dump and replicate, make sure it has proper privileges.
    - `MYSQL_MASTER_PASSWORD`: password for master user.
  - At least set a `--server-id`
