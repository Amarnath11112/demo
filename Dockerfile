RUN apt-get update \
apt-get install -y -q curl gnupg2
RUN curl http://nginx.org/keys/nginx_signing.key | apt-key add -

RUN apt-get update \
apt-get install -y -q nginx
RUN rm -rf /var/www/html/*
COPY index.html /var/www/html/
#ADD nginx.conf /etc/nginx/
#ADD server.conf /etc/nginx/conf.d

EXPOSE 443 80

CMD [&quot;nginx&quot;, &quot;-g&quot;, &quot;daemon off;&quot;]
