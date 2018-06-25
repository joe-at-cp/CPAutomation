#!/bin/bash

#Check Point Automation Training 

#Login
echo '[+] Login'
mgmt_cli login user "api_user" password "vpn123" session-name "MgmtCli Delete Rule" > sid.txt

#Delete Rule
echo '[+] Delete Rule'
mgmt_cli delete access-rule layer "Network" name "API Rule" -s sid.txt

#Publish
echo '[+] Publish'
mgmt_cli publish -s sid.txt

#Logout
echo '[+] Logout'
mgmt_cli logout -s sid.txt

rm sid.txt
