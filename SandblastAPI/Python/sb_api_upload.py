#!/usr/bin/python

#Check Point Automation Training

import requests, json, sys, os

api_key=os.environ["cp_sb_key"]

if len(sys.argv) == 2:
	file=sys.argv[1]	
	print 'Uploading File for Emulation: '+file
	service = "https://te.checkpoint.com/tecloud/api/v1/file/upload"
	headers = {'Authorization': api_key}
	request = { 'request': { 'file_name': file, 'features': ['av','te','extraction'], 'te': { 'reports': ['pdf','xml'] } } }
	
	files = {'file': open(file,'rb'), 'request': json.dumps(request)}
	response = requests.post(service, headers=headers, files=files)
	responseText = json.loads(response.text)
	print json.dumps(responseText, indent=4, sort_keys=True)

else:
	print ''
	print 'Usage'
	print './sb_api_emulate_file.py <File_To_Emulate>'
