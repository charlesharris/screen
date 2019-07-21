#!/bin/bash

mkdir data && cd data
while read i;
  do
    git clone $i;
  done < <(curl -s https://api.github.com/orgs/datasets/repos?per_page=100 | jq -r '.[].clone_url')
