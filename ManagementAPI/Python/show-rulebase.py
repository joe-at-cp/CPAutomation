#!/usr/bin/python

#Check Point Automation Training

import requests, json, urllib3, time, os

#Disable SSL cert warning on requests call
urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)

#Environment Variables
cp_mgmt_url=os.environ["cp_mgmt_url"]
cp_mgmt_user=os.environ["cp_mgmt_user"]
cp_mgmt_pass=os.environ["cp_mgmt_pass"]
cp_sid=''


#Login
print('[+] Login')

url=cp_mgmt_url+'/login'
headers = {'Content-type': 'application/json', 'Accept': 'bla'}
data = {'user': cp_mgmt_user, 'password': cp_mgmt_pass, 'session-name':'Show Rulebase'}
r = requests.post(url, data=json.dumps(data), headers=headers, verify=False)
jsonreturn = json.loads(r.text)
cp_sid = jsonreturn['sid']
print json.dumps(jsonreturn, indent=4, sort_keys=True)

#Add Host 
print('[+] Add Host')

url=cp_mgmt_url+'/show-access-rulebase' #Set API URL
headers = {'Content-type': 'application/json', 'Accept': 'bla', 'X-chkp-sid': cp_sid}
data = {'name':'Standard'}
r = requests.post(url, data=json.dumps(data), headers=headers, verify=False)
jsonreturn = json.loads(r.text)
print json.dumps(jsonreturn, indent=4, sort_keys=True)


#Publish 
print('[+] Publish')

url=cp_mgmt_url+'/publish'
headers = {'Content-type': 'application/json', 'Accept': 'bla', 'X-chkp-sid': cp_sid}
r = requests.post(url, data='{}', headers=headers, verify=False)
jsonreturn = json.loads(r.text) #Convert and store API reply as JSON
print json.dumps(jsonreturn, indent=4, sort_keys=True)

#Logout
print('[+] Logout')

url=cp_mgmt_url+'/logout'
headers = {'Content-type': 'application/json', 'Accept': 'bla', 'X-chkp-sid': cp_sid}
r = requests.post(url, data='{}', headers=headers, verify=False)
jsonreturn = json.loads(r.text)
print json.dumps(jsonreturn, indent=4, sort_keys=True)



