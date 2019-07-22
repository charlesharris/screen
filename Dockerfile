FROM debian:jessie AS init

RUN apt-get update && apt-get install -y \
    git \
    curl \
    jq

WORKDIR /root

COPY docker/init/mkdata.sh /root/mkdata.sh
RUN chmod a+x mkdata.sh

RUN ./mkdata.sh

# Debian uses mawk by default, which can't handle
# some of the files with large field counts, so we'll
# use GNU awk instead.
RUN apt-get install -y gawk


RUN mv /root/data/geoip2-ipv4/data/geoip2-ipv4.csv /root/data/geoip2-ipv4/data/geoip2-ipv4.csv.gross \
 && tr  \\n </root/data/geoip2-ipv4/data/geoip2-ipv4.csv.gross >/root/data/geoip2-ipv4/data/geoip2-ipv4.csv

COPY ./docker/awk/* ./src/
