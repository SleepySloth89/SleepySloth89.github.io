#!/bin/bash

banner='//       _____  .__        .__         ____   ____    .__                                                                               __   
//      /     \ |__| _____ |__|______  \   \ /   /_ __|  |   ____      _____    ______ ______ ____   ______ ______ _____   ____   _____/  |_ 
//     /  \ /  \|  |/     \|  \_  __ \  \   Y   /  |  \  |  /    \     \__  \  /  ___//  ___// __ \ /  ___//  ___//     \_/ __ \ /    \   __\
//    /    Y    \  |  Y Y  \  ||  | \/   \     /|  |  /  |_|   |  \     / __ \_\___ \ \___ \\  ___/ \___ \ \___ \|  Y Y  \  ___/|   |  \  |  
//    \____|__  /__|__|_|  /__||__|       \___/ |____/|____/___|  /____(____  /____  >____  >\___  >____  >____  >__|_|  /\___  >___|  /__|  
//            \/         \/                                     \/_____/    \/     \/     \/     \/     \/     \/      \/     \/     \/      
'
while IFS= read -r line; do
    echo "$line"
    sleep 0.1
done <<<  "$banner"

echo "1) Port scans"
echo "2) linux Security audit"
echo "3) rootkit discovery"


read -p "choose option:" choose

case "$choose" in

    1)
        echo "portscans"

		echo "1) port scan"
		echo "2) vulnscan"
		
	read -p "choose option:" choice2

        case "$choice2" in

   	1) echo "port scan"

		read -p "Enter target:" target

			sudo nmap --scan-delay 2s --max-rate 1 -Pn -p 21,22,23,25,53,80,8080,443,3389,445,135 "$target"
        	;;

        2) echo "vuln_scan"

	 	read -p "Enter target:" target

			sudo nmap -sV --script vuln "$target"
                ;;

	    *)  echo "invalid operation"
                ;;
        esac

	;;

    2)
        echo "Linux Security Audit"
		sudo lynis audit system
	 ;;

    3)
        echo "rootkit discovery"

		sudo chkrootkit

	;;

    *)
        echo "invalid option"
        ;;

esac
