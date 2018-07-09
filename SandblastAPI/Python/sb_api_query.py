#!/usr/bin/python

#Check Point Automation Training

import requests, json, sys, os

api_key=os.environ["cp_sb_key"]

if len(sys.argv) == 2:
	service = "https://te.checkpoint.com/tecloud/api/v1/file/query"
	request = { 'request': [ { 'md5': sys.argv[1], 'features': ['av','te','extraction'], 'te': { 'reports': ['pdf','xml'] } } ] }

	response = requests.post(service, headers={'Authorization': api_key}, data= json.dumps(request))
	responseText = json.loads(response.text)
	print json.dumps(responseText, indent=4, sort_keys=True)
else:
	print 'Please provide the MD5 sum of the file!'
	print 'Usage: ./sb_api_query.py <MD5sum_of_File>'
