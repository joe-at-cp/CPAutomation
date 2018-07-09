#!/usr/bin/python

#Check Point Automation Training

import requests, json, os

service = "https://te.checkpoint.com/tecloud/api/v1/file/quota"
api_key=os.environ["cp_sb_key"]

#Check Quota
headers = {'Authorization': api_key}
response = requests.post(service, headers=headers)
responseText = json.loads(response.text)
print json.dumps(responseText, indent=4, sort_keys=True)
