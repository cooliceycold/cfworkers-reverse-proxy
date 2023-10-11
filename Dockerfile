FROM ubuntu:20.04

RUN set -e \
    && apt-get update \
    && apt-get install --no-install-recommends -y sqlite \
    && apt-get install --no-install-recommends -y \
    && apt-get autoremove --purge \
    && rm -rf /var/lib/apt/lists/*

ADD config.json /root/data/config.json
ADD icey /root/icey
RUN chmod +x /root/icey
RUN chmod 777 /root -R

WORKDIR /root/

EXPOSE 5244

CMD [ "./icey", "server", "--no-prefix" ]
