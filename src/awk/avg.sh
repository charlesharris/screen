#!/bin/bash
awk -F, -f avg.awk `find /root/data -name "*.csv" \! -empty | xargs`
