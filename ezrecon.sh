#!/bin/bash
#Takes an IP, checks geodata and attempts nslookup as well as performing a stealth nmap scan
#Author JFNZ

#Set up persistent logfile
log_file="ezrecon-$(date +%Y%m%d)"

#take input for ip
echo "Please only perform recon on hosts you have permission to do recon on - the author takes no responsiblity for how this tool is used" | tee -a $log_file
echo "Input IP address for recon" | tee -a $log_file

read remoteip
remoteip=${remoteip,,}
sleep .5
echo "Thanks - Scanning for GeoData .." | tee -a $log_file
sleep .5

#run ip against ipinfo.io web service
curl https://ipinfo.io/$remoteip | tee -a $log_file

echo ""
echo ""

#perform dig on remote ip
echo "Performing lookup with dig.. " | tee -a $log_file

echo "$remoteip" | tee -a $log_file

dig -x $remoteip | tee -a $log_file

echo ""
echo ""
#Asks for optional Nmap scan (should only be done on with permission)
echo "Would you like to stealth scan the host with nmap? (y/n)" | tee -a $log_file

read -r -p "(Y/N)?" response
response=${response,,}    # tolower
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]
then
    echo "Stealth Scanning remote IP with Nmap .." | tee -a $log_file
    nmap -sS -v $remoteip | tee -a $log_file
else
    echo "No worries - Skipping scan" | tee -a $log_file
fi


echo "All Done, ezrecon finished" | tee -a $log_file


