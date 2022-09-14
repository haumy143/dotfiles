#!/bin/bash

IPaddr=$1

echo $IPaddr


ping_scan () {
    nmap -PE -sn -oG - $IPaddr/24
}

tcp/ping_scan () {
    nmap -sP -oG - $IPaddr/24
}

host-fast_scan () {
    nmap -sS -F - $IPaddr/24
}

host-main_scan () {
    nmap -sV -Pn -p0- --reason --stats-every 60s $IPaddr/24
}

network-main_scan () {
    nmap -sV -Pn -p0- -T4 -A -oG - --reason --stats-every 60s $IPaddr/24
}

choice=0
# Main display
printf "#####################################################\n"
printf "################ Common NMAP Scans ##################\n"
printf "#####################################################\n"
printf "\n"
printf "IP-Address = $IPaddr\n"
printf "\n"
printf "Enter number to select an option\n"
printf "1) Ping-Scan\n"
printf "2) tcp/ping_scan\n"
printf "3) host-fast_scan\n"
printf "4) host-main_scan\n"
printf "5) network-main_scan\n"
printf "Answer: "
printf "$1"


while [ $choice -eq 0 ]; do
read -r choice
        case $choice in
                1 ) ping_scan ;;
                2 ) tcp/ping_scan ;;
                3 ) host-fast_scan ;;
                4 ) host-main_scan ;;
                5 ) network-main_scan ;;
        esac
done
