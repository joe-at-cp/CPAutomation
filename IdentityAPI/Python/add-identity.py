#!/usr/bin/python

#Check Point Automation Training

import requests, json, urllib3, os

#Disable SSL cert warning on requests call
urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)

#Environment Variables
cp_gw_url=os.environ["cp_gw_url"]
cp_gw_pass=os.environ["cp_gw_pass"]
cp_gw_role=os.environ["cp_gw_role"]


#Add Identity

url=cp_gw_url+'add-identity'
headers = {'Content-type': 'application/json', 'Accept': 'bla'}
data = {'shared-secret': cp_gw_pass, 'ip-address': '4.2.2.4', 'machine': 'Blocked Host', 'identity-source': 'Python Add Identity','calculate-roles':0,'session-timeout':300,'fetch-machine-groups':0,'roles':[cp_gw_role]}
r = requests.post(url, data=json.dumps(data), headers=headers, verify=False)
jsonreturn = json.loads(r.text)
print json.dumps(jsonreturn, indent=4, sort_keys=True)
