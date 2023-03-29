FROM mysql:latest

ADD ./config /etc/mysql/conf.d

ENV MYSQL_ROOT_PASSWORD=qazxsw

ADD init.sql /docker-entrypoint-initdb.d