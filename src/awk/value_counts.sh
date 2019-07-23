#!/bin/bash

# Copy the original so we can revert after our script runs
cp /root/data/geoip2-ipv4/data/geoip2-ipv4.csv /root/data/geoip2-ipv4/data/geoip2-ipv4.orig

# Clean up the EOL characters in this one file that was causing the most issues parsing with CLI tools
mv /root/data/geoip2-ipv4/data/geoip2-ipv4.csv /root/data/geoip2-ipv4/data/geoip2-ipv4.csv.bad-eols \
 && tr  \\n </root/data/geoip2-ipv4/data/geoip2-ipv4.csv.bad-eols >/root/data/geoip2-ipv4/data/geoip2-ipv4.csv

awk -F, -f /root/src/awk/value_counts.awk `find /root/data -name "*.csv" \! -empty | xargs` >value_counts.awk.csv

mv /root/data/geoip2-ipv4/data/geoip2-ipv4.orig /root/data/geoip2-ipv4/data/geoip2-ipv4.csv
