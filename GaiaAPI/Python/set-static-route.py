#!/usr/bin/python

#Check Point Automation Training

import requests, json, urllib3, time, os

#Disable SSL cert warning on requests call
urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)

#Environment Variables
cp_gw_url=os.environ["cp_gw_url"]
cp_gw_user=os.environ["cp_gw_user"]
cp_gw_pass=os.environ["cp_gw_pass"]


#Login
print('[+] Login')

url=cp_gw_url+'/login'
headers = {'Content-type': 'application/json', 'Accept': 'bla'}
data = {'user': cp_gw_user, 'password': cp_gw_pass}
r = requests.post(url, data=json.dumps(data), headers=headers, verify=False)
jsonreturn = json.loads(r.text)
cp_sid = jsonreturn['sid']
print json.dumps(jsonreturn, indent=4, sort_keys=True)

#Set Static route 
print('[+] Set Route')

url=cp_gw_url+'/set-static-route' #Set API URL
headers = {'Content-type': 'application/json', 'Accept': 'bla', 'X-chkp-sid': cp_sid}
data = {'address':'4.2.2.4','mask-length':32,'nexthop-address':'192.168.1.1','state':'true'}
r = requests.post(url, data=json.dumps(data), headers=headers, verify=False)
jsonreturn = json.loads(r.text)
print json.dumps(jsonreturn, indent=4, sort_keys=True)


