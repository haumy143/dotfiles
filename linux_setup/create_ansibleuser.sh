#!/bin/bash

printf "Server IP: "
read -r servers
printf "User: "
read -r user

ssh $user@$server 

sudo useradd -m ansible
passwd ansible