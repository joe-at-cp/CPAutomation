#!/bin/bash

#Check Point Automation Training

#Create VPC
echo '[+] Create-VPC'
VPCID_RAW=`aws ec2 create-vpc --cidr-block 10.0.0.0/16`
$VPCID=`echo $VPCID_RAW | ./jq-linux64 '.Vpc.VpcId' | sed -e 's/^"//' -e 's/"$//'`
echo $VPCID_RAW | ./jq-linux64


#Create Subnet In VPC
echo '[+] Create-Subnet'
SUBNETID_RAW=`aws ec2 create-subnet --vpc-id $VPCID --cidr-block 10.0.1.0/24`
SUBNETID=`echo $SUBNETID_RAW | ./jq-linux64 '.Subnet.SubnetId' | sed -e 's/^"//' -e 's/"$//'`
echo $SUBNETID_RAW | ./jq-linux64

#Create Internet Gateway
echo '[+] Creating-Internet-Gateway'
INETGW_RAW=`aws ec2 create-internet-gateway`
INETGW=`echo $INETGW_RAW | ./jq-linux64 '.InternetGateway.InternetGatewayId' | sed -e 's/^"//' -e 's/"$//'`
echo $INETGW_RAW | ./jq-linux64

#Attach Internet Gateway to VPC
echo '[+] Attach-Internet-Gateway'
aws ec2 attach-internet-gateway --internet-gateway-id $INETGW --vpc-id $VPCID | ./jq-linux64


#Create Security Group
echo '[+] Creating New Security Group'
SECGROUP_RAW=`aws ec2 create-security-group --group-name AutomationSecurityGroup --description "AutomationGroup" --vpc-id $VPCID`
SECGROUP=`echo $SECGROUP_RAW | ./jq-linux64 '.GroupId' | sed -e 's/^"//' -e 's/"$//'`
echo $SECGROUP_RAW | ./jq-linux64

#Add Rules into Security Group
echo '[+] Authorize-Security-Group-Ingress'
aws ec2 authorize-security-group-ingress --group-id $SECGROUP --protocol tcp --port 22 --cidr 0.0.0.0/0
aws ec2 authorize-security-group-ingress --group-id $SECGROUP --protocol tcp --port 80 --cidr 0.0.0.0/0
aws ec2 authorize-security-group-ingress --group-id $SECGROUP --protocol tcp --port 5901 --cidr 0.0.0.0/0
aws ec2 authorize-security-group-ingress --group-id $SECGROUP --protocol icmp --port -1 --cidr 0.0.0.0/0

#Gather VPC Subnet ID
SUBNETID_RAW=`aws ec2 describe-subnets --filters "Name=vpc-id,Values=$VPCID" --query 'Subnets[*].{ID:SubnetId,CIDR:CidrBlock}'`
SUBNETID=`echo $SUBNETID_RAW | ./jq-linux64 '.[] .ID' | sed -e 's/^"//' -e 's/"$//'`
echo $SUBNETID_RAW | ./jq-linux64


#Create Routing Table
echo '[+] Creating Route Table'
ROUTETABLE=`aws ec2 create-route-table --vpc-id $VPCID | ./jq-linux64 '.RouteTable.RouteTableId' | sed -e 's/^"//' -e 's/"$//'`
echo '[-]   '$ROUTETABLE

#Create Default Route
echo '[+] Creating Default Route'
aws ec2 create-route --route-table-id $ROUTETABLE --destination-cidr-block 0.0.0.0/0 --gateway-id $INETGW > /dev/null

#Associate Routing Table
echo '[+] Associate Routing Table To VPC Subnet'
aws ec2 associate-route-table  --subnet-id $SUBNETID --route-table-id $ROUTETABLE > /dev/null

#Launch Image and Get InstanceId in Return
echo '[+] Deploying AWS Image'
InstanceID=`aws ec2 run-instances --image-id ami-ea846afc --count 1 --instance-type t2.micro --security-group-ids $SECGROUP --key-name AutomationTraining --subnet-id $SUBNETID |  ./jq-linux64 '.Instances[0] .InstanceId' | sed -e 's/^"//' -e 's/"$//'`
echo '[-]   Instance Id: '$InstanceID

#Allowcate public address and store it
echo '[+] Allowcating Public IP'
IPRETURN=`aws ec2 allocate-address`
PublicIp=`echo $IPRETURN | ./jq-linux64 '.PublicIp' | sed -e 's/^"//' -e 's/"$//'`
IPALLOC=`echo $IPRETURN | ./jq-linux64 '.AllocationId' | sed -e 's/^"//' -e 's/"$//'`
echo '[-]   Public IP: '$PublicIp
echo '[-]   Allocation Id: '$IPALLOC

echo '[+] Waiting for Instance to Startup...'

sleep 25s

#Asign public ip to instance
echo '[+] Assigning Public Ip to Instance...'
ASSOCID=`aws ec2 associate-address --instance-id $InstanceID --public-ip $PublicIp | ./jq-linux64 '.AssociationId' | sed -e 's/^"//' -e 's/"$//'`
echo '[+] Complete!'

echo '[+] Writing .VNC File'
echo '[connection]' > Desktop.vnc
echo 'host='$PublicIp >> Desktop.vnc
echo 'port=5901' >> Desktop.vnc
echo 'password='$InstanceID >> Desktop.vnc

echo ''
echo 'When ready to delete, hit ENTER...'
read input

echo '[+] Deleteing AWS Environment!'

echo '[!] Disassoicating Public IP'
aws ec2 disassociate-address --association-id $ASSOCID

sleep 3s
echo '[!] Releasing Public IP'
aws ec2 release-address --allocation-id $IPALLOC

sleep 3s
echo '[!] Terminating Instance...'
aws ec2 terminate-instances --instance-ids $InstanceID > /dev/null

sleep 2m
echo '[!] Deleting Security Group'
aws ec2 delete-security-group --group-id $SECGROUP

echo '[!] Deleting Subnet'
aws ec2 delete-subnet --subnet-id $SUBNETID
sleep 3s

echo '[!] Deleting Route Table'
aws ec2 delete-route-table --route-table-id $ROUTETABLE

echo '[!] Detach Internet Gateway From VPC'
aws ec2 detach-internet-gateway --internet-gateway-id $INETGW --vpc-id $VPCID

echo '[!] Deleting Internet Gateway'
aws ec2 delete-internet-gateway --internet-gateway-id $INETGW

echo '[!] Deleting VPC'
aws ec2 delete-vpc --vpc-id $VPCID

