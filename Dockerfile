FROM debian:jessie

RUN apt-get update && apt-get install -y \
    git \
    curl \
    jq

WORKDIR /root
RUN ["/bin/bash", "-c", "mkdir data && cd data && while read i; do git clone $i; done < <(curl -s https://api.github.com/orgs/datasets/repos?per_page=100 | jq -r '.[].clone_url')"]


# Clean up the EOL characters in this one file that was causing the most issues parsing with CLI tools
RUN mv /root/data/geoip2-ipv4/data/geoip2-ipv4.csv /root/data/geoip2-ipv4/data/geoip2-ipv4.csv.gross \
 && tr  \\n </root/data/geoip2-ipv4/data/geoip2-ipv4.csv.gross >/root/data/geoip2-ipv4/data/geoip2-ipv4.csv

# Debian uses mawk by default, which can't handle
# some of the files with large field counts, so we'll
# use GNU awk instead.
RUN apt-get install -y \
  gawk \
  python3

COPY ./src/awk/* ./src/awk/
COPY ./src/python/* ./src/python/
