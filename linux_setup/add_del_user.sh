#!/bin/bash

create_admin () {
        printf "Enter Username: "
        read -r user_name
        printf "Enter Password: "
        read -r user_passwd
        printf "do you want to create a home directory?(y/n): "
        read -r homedir_answer

        while true; do
                case $homedir_answer in
                        y )     useradd -m -p $(perl -e 'print crypt($ARGV[0], "password")' "$user_passwd") $user_name
                                tail /etc/passwd | grep $user_name
                                usermod -aG sudo $user_name
                                printf "created sudo user $user_name with home directory\n"
                                break ;;

                        n )     useradd -p $(perl -e 'print crypt($ARGV[0], "password")' "$user_passwd") $user_name
                                tail  /etc/passwd | grep $user_name
                                usermod -aG sudo $user_name
                                printf "created sudo user $user_name\n"
                                break ;;

                        * )     printf "invalid response, try again\n"
                                printf "do you want to create a home directory?(y/n): "
                                read -r homedir_answer ;;
                esac
        done

        printf "should the user $user_name be added to a group?(y/n): "
        read -r group_answer
        
        while true; do
                case $group_answer in
                        y )     getent group | cut -d: -f1
                                printf "whats the name of the group: "
                                read -r group_name
                                usermod -aG $group_name $user_name
                                printf "added $user_name to group $group_name\n"
                                break ;;
                                
                        n )     break ;;

                        * )     printf "invalid response, try again\n"
                                printf "do you want to create a home directory?(y/n): "
                                read -r homedir_answer ;;
                esac
        done
        printf "finished!!!\n"
}

create_user () {
        printf "Enter Username: "
        read -r user_name
        printf "Enter Password: "
        read -r user_passwd
        printf "do you want to create a home directory?(y/n): "
        read -r homedir_answer

        while true; do
                case $homedir_answer in
                        y )     useradd -m -p $(perl -e 'print crypt($ARGV[0], "password")' "$user_passwd") $user_name
                                tail /etc/passwd | grep $user_name
                                printf "created user $user_name with home directory\n"
                                break ;;

                        n )     useradd -p $(perl -e 'print crypt($ARGV[0], "password")' "$user_passwd") $user_name
                                tail  /etc/passwd | grep $user_name
                                printf "created user $user_name\n"
                                break ;;

                        * )     printf "invalid response, try again\n"
                                printf "do you want to create a home directory?(y/n): "
                                read -r homedir_answer ;;
                esac
        done

        printf "should the user $user_name be added to a group?(y/n): "
        read -r group_answer
        
        while true; do
                case $group_answer in
                        y )     printf "printing all groups: \n"
                                getent group | cut -d: -f1
                                printf "whats the name of the group: "
                                read -r group_name
                                usermod -aG $group_name $user_name
                                printf "added $user_name to group $group_name\n"
                                break ;;
                                
                        n )     break ;;

                        * )     printf "invalid response, try again\n"
                                printf "do you want to create a home directory?(y/n): "
                                read -r homedir_answer ;;
                esac
        done
        printf "finished!!!\n"
}

create_from_file () {
	printf "Path to file:"
        read -r -e user_list
	printf "should the user be added to a group?(y/n)"
	read -r group_answer
        
        while true; do
                case $group_answer in
                        y )     printf "printing all groups: \n"
                                getent group | cut -d: -f1
                                printf "whats the name of the group: "
                                read -r group_name
                                break ;;
                                
                        n )     break ;;

                        * )     printf "invalid response, try again\n"
                                printf "do you want to create a home directory?(y/n): "
                                read -r homedir_answer ;;
                esac
        done



	if [ "$group_answer" = "y" ]; then

        	while read -r user_name
        	do
        		useradd -p $(perl -e 'print crypt($ARGV[0], "password")' "$user_name") $user_name
			usermod -aG $group_name $user_name
                        passwd --expire $user_name
        		printf "created user $user_name and added them to group $group_name \n"
        	done < $user_list
	else 
		while read -r user_name
                do
                        useradd -p $(perl -e 'print crypt($ARGV[0], "password")' "$user_name") $user_name
                        passwd --expire $user_name
                        printf "created user $user_name\n"
                done < $user_list
	fi
        
        printf "#####################################################\n"
	printf "###created all users with the username as password###\n"
        printf "#####################################################\n"
}

delete_user () {
        printf "User to be deleted: "
        read -r user_name
        userdel $user_name
        user_directory=/home/$user_name

        if [ -d "$user_directory" ]; then
                rm -r /home/"$user_name"
        fi
        
        printf "Deleted user $user_name"
}

choice=0
# Main display
printf "#####################################################\n"
printf "############### RUN SCRIPT AS SUDO! #################\n"
printf "#####################################################\n"
printf "\n"
printf "Enter number to select an option\n"
printf "1) Add SuperUser\n"
printf "2) Add normal User\n"
printf "3) Add multiple Users from file\n"
printf "4) Delete User and /home directory\n"
printf "Answer: "

while [ $choice -eq 0 ]; do
read -r choice
        case $choice in
                1 ) create_admin ;;
                2 ) create_user ;;
                3 ) create_from_file ;;
                4 ) delete_user ;;
        esac
done