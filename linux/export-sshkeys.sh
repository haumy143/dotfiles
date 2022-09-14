#!/bin/bash

printf "Path to SSH-Key: "
read -er key
printf "1) read IPs from file\n"
printf "2) enter IPs manually\n"
printf "Answer: "
read -r option

    while true; do
            case $option in
                    1 ) printf "Path to file: "
                        read -er file
                        printf "SSH-User on Servers: "
                        read -er user
                    	while read -r server
        	            do
                            printf "copying to $server\n"
                            ssh-copy-id -i $key $user@$server
                            printf "done\n"
        	            done < $file
                        break ;;
                        
                    2 )     
                            break ;;

                    * )     printf "1) read IPs from file\n"
                            printf "2) enter IPs manually\n"
                            printf "Answer: "
                            read -r option ;;
            esac
done