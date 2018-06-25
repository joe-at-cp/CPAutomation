#!/bin/bash

#Check Point Automation Training 

#Login
echo '[+] Login'
mgmt_cli login user "api_user" password "vpn123" session-name "MgmtCli Add Rule" > sid.txt

#Add Rule
echo '[+] Add Rule'
mgmt_cli add access-rule layer "Network" position 1 name "API Rule" action "Accept" source "InternalZone" destination "DMZZone" track "Extended Log"  service.1 "ssh" service.2 "icmp-proto" service.3 "sqlnet2" -s sid.txt

#Publish
echo '[+] Publish'
mgmt_cli publish -s sid.txt

#Logout
echo '[+] Logout'
mgmt_cli logout -s sid.txt

rm sid.txt
