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

COPY ./docker/awk/* ./src/
