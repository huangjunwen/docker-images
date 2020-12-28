FROM mysql:8.0.19

COPY mysql8-gtid-repl.sh /usr/local/bin/

ENTRYPOINT ["mysql8-gtid-repl.sh"]

CMD ["mysqld"]
