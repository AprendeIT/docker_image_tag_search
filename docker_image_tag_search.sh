#!/bin/bash

i=0
is_num='^-?[0-9]+([.][0-9]+)?$'
if  <p class="wiki-page-missing">$2 =~ $is_num</p> ; then
        max_pages=$2
else
        max_pages=20
fi

for i in $(seq 0 $max_pages)
do
   i=$((i+1))
   timeout 10 curl https://registry.hub.docker.com/v2/repositories/library/$1/tags/?page=$i 2>/dev/null|jq '."results"[]["name"]'

done
