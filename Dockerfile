FROM alpine:latest
LABEL maintainer="gwaewion@gmail.com"
EXPOSE 80
VOLUME /nginx

ENV DOMAIN_NAME CHANGE_ME

RUN apk update
RUN apk add nginx
RUN mkdir /root/cert

COPY cert/* /root/cert/
COPY default.conf postfixadmin.conf /etc/nginx/conf.d/
COPY nginx.conf /etc/nginx/
COPY run.sh /root/

CMD ["sh", "/root/run.sh"]
