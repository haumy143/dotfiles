#!/bin/bash

printf "path to servers.txt: "
read -r servers_file
servers=$(cat $servers_file)

echo -n "Enter the username: "
read name
echo -n "Enter the user id: "
read uid

for i in $servers; do
echo $i
ssh $i "sudo useradd -m -u $uid ansible"
if [ $? -eq 0 ]; then
echo "User $name added on $i"
else
echo "Error on $i"
fi
done