#!/bin/bash
awk -F, -f value_counts.awk `find /root/data -name "*.csv" \! -empty | xargs` >value_counts.awk.csv
