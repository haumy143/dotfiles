#!/bin/bash

create_admin () {
        echo -e "Enter Username"
        read user_name
        echo -e "Enter Password"
        read user_passwd
        echo -e "do you want to create a home directory?(y/n)"
        read homedir_answer

        if [ $homedir_answer -eq "y" ]; then
                useradd -m -p $(perl -e 'print crypt($ARGV[0], "password")' "$user_passwd") $user_name
                tail /etc/passwd | grep $user_name
                usermod -aG sudo $user_name
        else
                useradd -p $(perl -e 'print crypt($ARGV[0], "password")' "$user_passwd") $user_name
                tail  /etc/passwd | grep $user_name
                usermod -aG sudo $user_name
        fi
}

create_user () {
        echo -e "Enter Username"
        read user_name
        echo -e "Enter Password"
        read user_passwd
        echo -e "do you want to create a home directory?(y/n)"
        read homedir_answer

        if [ $homedir_answer -eq "y" ]; then
                useradd -m -p $(perl -e 'print crypt($ARGV[0], "password")' "$user_passwd") $user_name
                tail /etc/passwd
        else

                useradd -p $(perl -e 'print crypt($ARGV[0], "password")' "$user_passwd") $user_name
                tail  /etc/passwd
        fi

        	echo "do you want to add $user_name to a group?(y/n)"
        	read group_answer

        if [$group_answer -eq "y"] ; then
                echo "to which group do you want to add the user?: "
                groups
                read group
                usermod -aG $group $user_name
	else
		echo "all done"
        fi
}

create_from_file () {
	echo -e "Enter file name for users:"
        read user_list
	echo -e "should the user be added to a group?(y/n)"
	read group_answer
	echo -e "which group: "
	groups
	read group

	if [$group_answer -eq "y"]; then

        	while read user_name
        	do
        		useradd -p $(perl -e 'print crypt($ARGV[0], "password")' "$user_name") $user_name
        		echo "created user $user_name"
			usermod -aG $group $user_name
        	done < $user_list
	else 
		while read user_name
                do
                        useradd -p $(perl -e 'print crypt($ARGV[0], "password")' "$user_name") $user_name
                        echo "created user $user_name"
                        usermod -aG $group $user_name
                done < $user_list
	fi
        
	echo "created all users with the username as password"

}

choice=5
# Main display
echo "Enter number to select an option"
echo
echo "1) Add SuperUser"
echo "2) Add normal User"
echo "3) Add multiple Users from file"
echo

while [ $choice -eq 5 ]; do

read choice

if [ $choice -eq 1 ] ; then    
	create_admin
	fi                   

if [ $choice -eq 2 ] ; then

        create_user
	fi

if [ $choice -eq 3 ] ; then
	create_from_file
	fi
done
