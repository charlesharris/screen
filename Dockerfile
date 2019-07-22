FROM debian:jessie AS init

RUN apt-get update && apt-get install -y \
    git \
    curl \
    jq

WORKDIR /root

COPY docker/init/mkdata.sh /root/mkdata.sh
RUN chmod a+x mkdata.sh

RUN ./mkdata.sh

RUN apt-get install -y \
  python3 \
  python3-pip

COPY ./docker/python/* ./src/
