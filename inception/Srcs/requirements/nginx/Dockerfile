FROM alpine:3.22

RUN apk update && apk add nginx openssl

COPY san.cnf /etc/ssl/san.cnf

RUN mkdir -p /etc/ssl/private

RUN openssl req -x509 -nodes -days 365 \
-newkey rsa:2048 \
-keyout /etc/ssl/private/nginx.key \
-out /etc/ssl/certs/nginx.crt \
-config /etc/ssl/san.cnf

COPY nginx.conf /etc/nginx/http.d/default.conf

RUN mkdir -p /run/nginx

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]