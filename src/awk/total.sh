#!/bin/bash
find /root/data -name "*.csv" \! -empty | xargs wc -l | tail -1 | awk '{print $1}'
