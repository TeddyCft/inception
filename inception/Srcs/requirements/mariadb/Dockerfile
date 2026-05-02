FROM alpine:3.22

RUN apk update && apk add mariadb mariadb-client

RUN mkdir -p /run/mysqld &&\
    chown -R mysql:mysql /run/mysqld &&\
    chown -R mysql:mysql /var/lib/mysql

EXPOSE 3306

COPY my.cnf /etc/my.cnf

COPY init.sh /init.sh

RUN chmod +x /init.sh

CMD ["/init.sh"]