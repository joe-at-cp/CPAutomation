#!/bin/bash

if [ -e $HOME/.aws/credentials ]
then
	ACCESSKEY=`cat $HOME/.aws/credentials | grep aws_access_key_id | awk '{print$3}'`
	SECRETACCESSKEY=`cat $HOME/.aws/credentials | grep aws_secret_access_key | awk '{print$3}'`
else
	echo 'AWS Credentials Not Found! Please Enter Them...'
	echo 'Enter AWS Access Key ID:'
	read ACCESSKEY
	echo 'Enter AWS Secret Access Key:'
	read SECRETACCESSKEY

fi

export AWS_ACCESS_KEY_ID=$ACCESSKEY
export AWS_SECRET_ACCESS_KEY=$SECRETACCESSKEY
