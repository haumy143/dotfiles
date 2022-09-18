#!/bin/bash

printf "path to ssh-key: "
read -r sshkey
printf "ssh user on server: "
read -r sshuser
printf "path to server txt: "
read -r server

while read -r server
    do
    ssh-copy-id -i $sshkey $sshuser@$server
    echo "key added to $server"
done < $server
