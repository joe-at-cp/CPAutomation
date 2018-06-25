#!/bin/bash

#Check Point Automation Training 

#Login
echo '[+] Login'
mgmt_cli login user "api_user" password "vpn123" session-name "MgmtCli Delete Host" > sid.txt

#Delete Host
echo '[+] Delete Host'
mgmt_cli delete host name "host5" -s sid.txt 

#Publish
echo '[+] Publish'
mgmt_cli publish -s sid.txt

#Logout
echo '[+] Logout'
mgmt_cli logout -s sid.txt

rm sid.txt
