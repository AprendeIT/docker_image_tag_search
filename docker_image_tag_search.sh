#!/bin/bash

URL="https://registry.hub.docker.com/v2/repositories/library/$1/tags/?page="


function credits {
    echo -e "docker_image_tag_search"
    echo -e "by Gerardo G. Urtiaga"
    echo -e "2019 (C) AprendeIT\n\n"
}

function showhelp {
    credits
    echo -e "You have used a wrong syntax"
    echo -e "You can use this script as follows:\n"
    echo -e "\tbash docker_image_tag_search.sh IMAGE_NAME"
    echo -e "\nIf you want to limit the number of results you have to set the max_page_number executing:"
    echo -e "\tbash docker_image_tag_search.sh IMAGE_NAME PAGE_NUMBER"
}



#Check if entry point is empty
if [ -z "$1" ]
then
    showhelp
    exit
fi


is_num='^-?[0-9]+([.][0-9]+)?$'
if  [[ $2 =~ $is_num ]]
then
    max_pages=$2
else
    max_pages=1
fi

i=0
for i in $(seq 0 $max_pages)
do
    i=$((i+1))
    timeout 10 curl $URL$i 2>/dev/null|jq '."results"[]["name"]'

done

