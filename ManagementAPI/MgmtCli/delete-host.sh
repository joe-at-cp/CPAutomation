#!/bin/bash

#Check Point Automation Training 

#Login
echo '[+] Login'
./mgmt_cli login -m $cp_mgmt_ip -u $cp_mgmt_user -p $cp_mgmt_pass session-name "MgmtCli Delete Host" > sid.txt

#Delete Host
echo '[+] Delete Host'
./mgmt_cli delete host name "host5" -s sid.txt 

#Publish
echo '[+] Publish'
./mgmt_cli publish -s sid.txt

#Logout
echo '[+] Logout'
./mgmt_cli logout -s sid.txt

rm sid.txt
