#!/bin/bash

if [ -z "$1" ]; then
    echo "gib username"
    exit
fi

ask_for_continue(){
	read -p "$1" -n 1 -r
	echo    # (optional) move to a new line
	if [[ ! $REPLY =~ ^[Yy]$ ]]
	then
	    exit
	fi
}


username=$1
url=https://api.github.com/users/${username}/repos
repos_json=$(curl ${url})

ssh_urls=$(jq '.[] .ssh_url' <<< "$repos_json")
for url in $ssh_urls;do
	echo ${url}
done 
ask_for_continue "Do you want to clone all repos?"
for url in $ssh_urls;do
	git clone ${url}
done
