#!/bin/bash
awk -F, -f value_count.awk `find /root/data -name "*.csv" \! -empty | xargs` >value_count.csv
