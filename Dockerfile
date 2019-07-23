FROM debian:jessie

RUN apt-get update && apt-get install -y \
    git \
    curl \
    jq

WORKDIR /root
RUN ["/bin/bash", "-c", "mkdir data && cd data && while read i; do git clone $i; done < <(curl -s https://api.github.com/orgs/datasets/repos?per_page=100 | jq -r '.[].clone_url')"]

# Debian uses mawk by default, which can't handle
# some of the files with large field counts, so we'll
# use GNU awk instead.
RUN apt-get install -y \
  gawk \
  python3

COPY ./src/awk/* ./src/awk/
COPY ./src/python/* ./src/python/
