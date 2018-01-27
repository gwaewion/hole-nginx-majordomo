#!/bin/sh

if [ -e /nginx/etc/nginx.conf ]
then
	chown -R nginx:nginx /nginx
	nginx
else
	sed -i "s/server_name		CHANGE_ME;/server_name		\""${DOMAIN_NAME}"\";/" /etc/nginx/conf.d/default.conf
	sed -i "s/server_name		CHANGE_ME;/server_name		\"pfadmin.mail."${DOMAIN_NAME}"\";/" /etc/nginx/conf.d/postfixadmin.conf
	sed -i "s/proxy_pass http:\/\/CHANGE_ME:8888;/proxy_pass http:\/\/"${DOMAIN_NAME}":8888;/" /etc/nginx/conf.d/postfixadmin.conf
	
	cp -R /etc/nginx/* /nginx/etc/
	mkdir /run/nginx /nginx/www /nginx/log /nginx/etc/cert
	mv /root/cert/* /nginx/etc/cert/
	chown nginx:nginx /run/nginx
	chown -R nginx:nginx /nginx
	nginx
fi
