FROM nginxproxy/nginx-proxy:alpine

COPY proxy.conf        /etc/nginx/
COPY uploadsize.conf   /etc/nginx/conf.d/
COPY vhost.d           /etc/nginx/vhost.d

RUN mkdir -p /certs/live/cloud.myhost.com \
	&& ln -s /certs/live/cloud.myhost.com /etc/nginx/certs
