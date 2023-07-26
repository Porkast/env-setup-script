FROM mariadb:latest

ADD ./config /etc/mysql/conf.d

ENV MARIADB_USER=guoshaofm
ENV MARIADB_PASSWORD=1qaz!QAZ
ENV MARIADB_ROOT_PASSWORD=1qaz!QAZ

ADD init.sql /docker-entrypoint-initdb.d
