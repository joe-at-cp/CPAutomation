#!/bin/bash

#Check Point Automation Training
#Ansible Install and Configuration Script

clear
echo "=========== Automation Server Installation Utility ==========="
echo " This utlity will install the following tools:"
echo "- Ansible"
echo "- AWS CLI"
echo "- Azure CLI"
echo "- NTP"


#Update Sources List
AZ_REPO=$(lsb_release -cs)
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | \
    sudo tee /etc/apt/sources.list.d/azure-cli.list
	
curl -L https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -



#APT update and download packages
sudo timedatectl set-ntp no
sudo apt-get update
sudo apt-get install -y ansible apt-transport-https azure-cli ntp awscli

#PIP Install Libs
pip install awscli --upgrade --user


clear
echo "==== Installing and Configuring Ansible ===="

#Clone Check Point Ansible libs
git clone --recursive https://github.com/CheckPoint-APIs-Team/cpAnsible
sudo mkdir /etc/ansible/modules
sudo cp -r cpAnsible/check_point_mgmt/ /usr/lib/python2.7/dist-packages/ansible/
sudo cp -r cpAnsible/check_point_mgmt/cp_mgmt_api_python_sdk/ /usr/lib/python2.7/dist-packages/

#/etc/ansible/ansible.cfg configuration
sudo echo 'library        = /usr/lib/python2.7/dist-packages/ansible/' >> /etc/ansible/ansible.cfg
sudo echo 'scp_if_ssh = True' >> /etc/ansible/ansible.cfg
sudo echo 'host_key_checking = False' >> /etc/ansible/ansible.cfg


#Remove Files
rm -rf cpAnsible/

#Create SSH Key
ssh-keygen -t rsa -f $HOME/.ssh/id_rsa -N ''




