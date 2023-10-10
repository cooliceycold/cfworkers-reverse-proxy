FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive \
    TZ=Asia/Shanghai


RUN set -e \
    && apt-get update \
    && apt-get install --no-install-recommends -y nginx git \
    && apt-get install --no-install-recommends -y \
    php php-curl php-fpm php7.4-mysql \
    && apt-get autoremove --purge \
    && rm -rf /var/lib/apt/lists/*

COPY dddtest.conf /etc/nginx/conf.d/
COPY run.sh /root/
RUN set -e \
    && rm /etc/nginx/sites-enabled/default \
    && chmod +x /root/run.sh \
    && git clone https://github.com/cooliceycold/dddtest.git /var/www/dddtest \
    && chmod -Rf 777 /var/www/dddtest

EXPOSE 80

CMD ["/root/run.sh"]
