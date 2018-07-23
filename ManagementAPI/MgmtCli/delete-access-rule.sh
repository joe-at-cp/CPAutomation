#!/bin/bash

#Check Point Automation Training 

#Login
echo '[+] Login'
./mgmt_cli login -m $cp_mgmt_ip -u $cp_mgmt_user -p $cp_mgmt_pass session-name "MgmtCli Delete Rule" > sid.txt

#Delete Rule
echo '[+] Delete Rule'
./mgmt_cli delete access-rule layer "Network" name "API Rule" -s sid.txt

#Publish
echo '[+] Publish'
./mgmt_cli publish -s sid.txt

#Logout
echo '[+] Logout'
./mgmt_cli logout -s sid.txt

rm sid.txt
