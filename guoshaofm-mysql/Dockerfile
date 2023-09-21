FROM mysql:8.1.0

ADD ./config /etc/mysql/conf.d

ENV MYSQL_USER=guoshaofm
ENV MYSQL_PASSWORD=1qaz!QAZ
ENV MYSQL_ROOT_PASSWORD=1qaz!QAZ

ADD init.sql /docker-entrypoint-initdb.d
