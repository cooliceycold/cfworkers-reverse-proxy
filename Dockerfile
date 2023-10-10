FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive \
    TZ=Asia/Shanghai


RUN set -e \
    && apt-get update \
    && apt-get install --no-install-recommends -y nginx sqlite redis git ca-certificates \
    && apt-get install --no-install-recommends -y \
    php-fpm php-curl php-fpm php-gd php-json php-mbstring php-redis php-sqlite3 php-xml \
    && apt-get autoremove --purge \
    && rm -rf /var/lib/apt/lists/*

COPY BDPHPRENDER.conf /etc/nginx/conf.d/
COPY run.sh /root/
RUN set -e \
    && rm /etc/nginx/sites-enabled/default \
    && chmod +x /root/run.sh \
    && git clone https://github.com/cooliceycold/BDPHPRENDER.git /var/www/BDPHPRENDER \
    && chmod -Rf 777 /var/www/BDPHPRENDER

EXPOSE 80

CMD ["/root/run.sh"]
