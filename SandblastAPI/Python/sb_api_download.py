#!/usr/bin/python

#Check Point Automation Training

import requests, json, sys, os

api_key=os.environ["cp_sb_key"]

if len(sys.argv) == 3:
	service = "https://te.checkpoint.com/tecloud/api/v1/file/download"
	headers = {'Authorization': api_key}
	print "Downloading File: "+sys.argv[1]
	params = {"id": sys.argv[1]}
	req = requests.get(service, headers=headers, params=params)
	print "HTTP Download: "+str(req.status_code)
	
	with open(sys.argv[2],"w") as report:
        	report.write(req.content)
	print "Saved File: "+sys.argv[2]

else:
	print 'Please provide the file ID from the output of the upload api call'
	print 'Usage: ./sb_api_download.py <File ID> <File Name>'
