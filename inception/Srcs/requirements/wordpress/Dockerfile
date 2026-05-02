FROM alpine:3.22

RUN apk update && \
apk add \
php83 \
php83-fpm \
php83-mysqli \
mariadb-client \
wget \
tar \
curl \
php83-phar \
php83-mbstring \
php83-iconv \
php83-xml \
php83-curl \
php83-phar \
php83-openssl
#geting all the packages
RUN mkdir -p /var/www/html/

WORKDIR /var/www/html/

RUN wget https://wordpress.org/wordpress-6.9.3.tar.gz && \
    tar -xzf wordpress-6.9.3.tar.gz --strip-components=1 &&\
    rm wordpress-6.9.3.tar.gz && \
    chown -R nobody:nobody /var/www/html && \
    #wordpress is set
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp
    #geting wp-cli to initialize the web site

EXPOSE 9000
COPY init.sh /init.sh

RUN chmod +x /init.sh

CMD ["/init.sh"]
