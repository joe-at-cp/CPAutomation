#!/bin/bash

#Check Point Automation Training

clear
echo "TOR Exit Node Blocker - IA API Version"

echo "Downloading Exit Node List from https://check.torproject.org/exit-addresses"
rm exit-addresses
wget https://check.torproject.org/exit-addresses

echo "Trimming Exit Node List..."
cat exit-addresses | grep ExitAddress | awk '{print $2 }' > NodeListCut.txt
nodecount=`wc -l NodeListCut.txt`

echo "Creating $nodecount Exit Node Identities..."
sleep 5
while read i; do

        curl -s -k -H "Content-Type: application/json" -X POST -d'{"shared-secret":"'$cp_gw_ia_pass'","ip-address":"'$i'","machine":"TORExitNode","identity-source":"TOR Exit Node Script","domain":"Production Domain","calculate-roles":0,"session-timeout":86400,"fetch-machine-groups":0,"roles":["'$cp_gw_role'"]}' $cp_gw_ia_url/add-identity | ./jq-linux64        
done <NodeListCut.txt

rm NodeListCut.txt
rm exit-addresses

