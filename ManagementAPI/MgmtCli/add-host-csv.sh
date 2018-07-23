#!/bin/bash

#Check Point Automation Training 

#Login
echo '[+] Login'
./mgmt_cli login -m $cp_mgmt_ip -u $cp_mgmt_user -p $cp_mgmt_pass session-name " Add Host From CSV" > sid.txt

#Add Host CSV
echo '[+] Add Hosts From CSV'
./mgmt_cli -r true add-host --batch addhostlist.csv -s sid.txt 

#Publish
echo '[+] Publish'
./mgmt_cli publish -s sid.txt

#Logout
echo '[+] Logout'
./mgmt_cli logout -s sid.txt

rm sid.txt
