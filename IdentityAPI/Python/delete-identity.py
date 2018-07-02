#!/usr/bin/python

#Check Point Automation Training

import requests, json, urllib3, os

#Disable SSL cert warning on requests call
urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)

#Environment Variables
cp_gw_url=os.environ["cp_gw_ia_url"]
cp_gw_pass=os.environ["cp_gw_pass"]
cp_gw_role=os.environ["cp_gw_role"]


#Delete Identity

url=cp_gw_url+'delete-identity'
headers = {'Content-type': 'application/json', 'Accept': 'bla'}
data = {'shared-secret': cp_gw_pass, 'ip-address': '4.2.2.4'}
r = requests.post(url, data=json.dumps(data), headers=headers, verify=False)
jsonreturn = json.loads(r.text)
print json.dumps(jsonreturn, indent=4, sort_keys=True)
