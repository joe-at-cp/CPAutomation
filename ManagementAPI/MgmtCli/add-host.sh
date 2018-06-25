#!/bin/bash

#Check Point Automation Training 

#Login
echo '[+] Login'
mgmt_cli login user "api_user" password "vpn123" session-name "MgmtCli Add Host" > sid.txt

#Add Host
echo '[+] Add Host'
mgmt_cli add host name "host5" ip-address "6.5.4.3" color "magenta" -s sid.txt 

#Publish
echo '[+] Publish'
mgmt_cli publish -s sid.txt

#Logout
echo '[+] Logout'
mgmt_cli logout -s sid.txt

rm sid.txt
