#!/bin/bash

#Auto Configuration Tool for Automation Server

clear
echo '====== Automation Training Configuration Script ======'
echo 'This script will configure your automation server for:'
echo 'Management API - Bash, Python, Ansible'
echo 'Gaia API - Bash, Python, Ansible'
echo 'Identity API - Bash, Python'
echo 'Sandblast API - Python'
echo ''
echo 'Environment variables will be added into your ~/.profile'
echo '=================== Management API ==================='
if [ -z "$cp_mgmt_ip" ]; then
    echo 'Management Server IP [ENTER]:'
	read mgmt_ip
else
    echo 'Management Server IP Already Configured! ['$cp_mgmt_ip']:'
fi

if [ -z "$cp_mgmt_user" ]; then
    echo 'Management Server API User [ENTER]:'
    read mgmt_user
else
    echo 'Management Server API User Already Configured! ['$cp_mgmt_user']:'
fi

if [ -z "$cp_mgmt_pass" ]; then
    echo 'Management Server API User Password [ENTER]:'
    read mgmt_pass
else
    echo 'Management Server API User Password Already Configured! ['$cp_mgmt_pass']:'
fi

if [ -z "$cp_mgmt_fingerprint" ]; then
    echo 'Management Server API Fingerprint (#api fingerprint) [ENTER]:'
    read mgmt_fingerprint
else
    echo 'Management Server API Fingerprint Already Configured! ['$cp_mgmt_fingerprint']:'
fi


echo '================= Gaia/Identity API =================='

if [ -z "$cp_gw_ip" ]; then
    echo 'Gateway IP [ENTER]:'
    read gw_ip
else
    echo 'Gateway IP Already Configured! ['$cp_gw_ip']:'
fi

if [ -z "$cp_gw_user" ]; then
    echo 'Gateway Username (Gaia API) [ENTER]:'
    read gw_user
else
    echo 'Gateway Username Already Configured! ['$cp_gw_user']:'
fi

if [ -z "$cp_gw_pass" ]; then
    echo 'Gateway Password (Gaia API) [ENTER]:'
    read gw_pass
else
    echo 'Gateway Password Already Configured! ['$cp_gw_pass']:'
fi

if [ -z "$cp_gw_ia_pass" ]; then
    echo 'Gateway Shared Secret (IA API) [ENTER]:'
	read gw_ia_pass
else
    echo 'Gateway Shared Secret (IA API) Already Configured! ['$cp_gw_ia_pass']:'
fi

if [ -z "$cp_gw_role" ]; then
    echo 'Identity Access Role [ENTER]:'
	read cp_gw_role
else
    echo 'Identity Access Role Already Configured! ['$cp_gw_role']:'
fi


echo '=================== Sandblast API ===================='

if [ -z "$cp_sb_key" ]; then
    echo 'Sandblast API Key [ENTER]:'
	read sb_key
else
    echo 'Sandblast API Key Already Configured! ['$cp_sb_key']:'
fi


echo '======================= AWS =========================='

if [ -f "$HOME/.aws/credentials" ]; then
    echo 'AWS Credentials: Good'
else
    echo 'AWS Credentials: Not configured! Run #aws configure'
fi

echo '====================== Azure ========================='

if [ -f "$HOME/.azure/azureProfile.json" ]; then
    echo 'Azure Credentials: Good'
else
    echo 'Azure Credentials: Not configured! Run #az configure'
fi


echo 'Configuring Environement Variables'

mgmt_url="https://$mgmt_ip/web_api/"
gw_ia_url="https://$gw_ip/_IA_API/"
gw_url="https://$gw_ip/rest/"

#Set Session Environment Variables
export cp_mgmt_ip=$mgmt_ip
export cp_mgmt_url=$mgmt_url
export cp_mgmt_user=$mgmt_user
export cp_mgmt_pass=$mgmt_pass
export cp_mgmt_fingerprint=$mgmt_fingerprint
export cp_gw_ip=$gw_ip
export cp_gw_user=$gw_user
export cp_gw_pass=$gw_pass
export cp_gw_url=$gw_url
export cp_gw_ia_url=$gw_ia_url
export cp_gw_ia_pass=$gw_ia_pass
export cp_sb_key=$sb_key
export cp_gw_role=$cp_gw_role
export AWS_REGION=$aws_region

#Backup existing .profile
cp -f $HOME/.profile $HOME/.profile.backup

#Save Environment Variables in .profile
echo "" $HOME/.profile
echo "export cp_mgmt_ip="$mgmt_ip >> $HOME/.profile
echo "export cp_mgmt_url="$mgmt_url >> $HOME/.profile
echo "export cp_mgmt_user="$mgmt_user >> $HOME/.profile
echo "export cp_mgmt_pass="$mgmt_pass >> $HOME/.profile
echo "export cp_mgmt_fingerprint="$mgmt_fingerprint >> $HOME/.profile
echo "export cp_gw_ip="$gw_ip >> $HOME/.profile
echo "export cp_gw_user="$gw_user >> $HOME/.profile
echo "export cp_gw_pass="$gw_pass >> $HOME/.profile
echo "export cp_gw_url="$gw_url >> $HOME/.profile
echo "export cp_gw_ia_url="$gw_ia_url >> $HOME/.profile
echo "export cp_gw_ia_pass="$gw_ia_pass >> $HOME/.profile
echo "export cp_sb_key="$sb_key >> $HOME/.profile
echo "export cp_gw_role="$cp_gw_role >> $HOME/.profile
echo "export AWS_REGION="$aws_region >> $HOME/.profile

#Set Ansible Check Point Hosts for Training

if [ -f ".configured" ]; then
    echo 'Ansible Hosts Already Configured: Skipping'
else
    sudo echo "" >> /etc/ansible/hosts
    sudo echo "[CheckPoint]" >> /etc/ansible/hosts
    sudo echo $cp_mgmt_ip" ansible_user=admin ansible_python_interpreter=/opt/CPsuite-R80/fw1/Python/bin/python" >> /etc/ansible/hosts
    sudo echo $cp_gw_ip" ansible_user=admin ansible_python_interpreter=/opt/CPsuite-R80/fw1/Python/bin/python" >> /etc/ansible/hosts
    touch .configured
fi

echo 'Done!'
#!/bin/bash

#Auto Configuration Tool for Automation Server

clear
echo '====== Automation Training Configuration Script ======'
echo 'This script will configure your automation server for:'
echo 'Management API - Bash, Python, Ansible'
echo 'Gaia API - Bash, Python, Ansible'
echo 'Identity API - Bash, Python'
echo 'Sandblast API - Python'
echo ''
echo 'Environment variables will be added into your ~/.profile'
echo '=================== Management API ==================='
if [ -z "$cp_mgmt_ip" ]; then
    echo 'Management Server IP [ENTER]:'
	read mgmt_ip
else
    echo 'Management Server IP Already Configured! ['$cp_mgmt_ip']:'
fi

if [ -z "$cp_mgmt_user" ]; then
    echo 'Management Server API User [ENTER]:'
    read mgmt_user
else
    echo 'Management Server API User Already Configured! ['$cp_mgmt_user']:'
fi

if [ -z "$cp_mgmt_pass" ]; then
    echo 'Management Server API User Password [ENTER]:'
    read mgmt_pass
else
    echo 'Management Server API User Password Already Configured! ['$cp_mgmt_pass']:'
fi

if [ -z "$cp_mgmt_fingerprint" ]; then
    echo 'Management Server API Fingerprint (#api fingerprint) [ENTER]:'
    read mgmt_fingerprint
else
    echo 'Management Server API Fingerprint Already Configured! ['$cp_mgmt_fingerprint']:'
fi


echo '================= Gaia/Identity API =================='

if [ -z "$cp_gw_ip" ]; then
    echo 'Gateway IP [ENTER]:'
    read gw_ip
else
    echo 'Gateway IP Already Configured! ['$cp_gw_ip']:'
fi

if [ -z "$cp_gw_user" ]; then
    echo 'Gateway Username (Gaia API) [ENTER]:'
    read gw_user
else
    echo 'Gateway Username Already Configured! ['$cp_gw_user']:'
fi

if [ -z "$cp_gw_pass" ]; then
    echo 'Gateway Password (Gaia API) [ENTER]:'
    read gw_pass
else
    echo 'Gateway Password Already Configured! ['$cp_gw_pass']:'
fi

if [ -z "$cp_gw_ia_pass" ]; then
    echo 'Gateway Shared Secret (IA API) [ENTER]:'
	read gw_ia_pass
else
    echo 'Gateway Shared Secret (IA API) Already Configured! ['$cp_gw_ia_pass']:'
fi

if [ -z "$cp_gw_role" ]; then
    echo 'Identity Access Role [ENTER]:'
	read cp_gw_role
else
    echo 'Identity Access Role Already Configured! ['$cp_gw_role']:'
fi


echo '=================== Sandblast API ===================='

if [ -z "$cp_sb_key" ]; then
    echo 'Sandblast API Key [ENTER]:'
	read sb_key
else
    echo 'Sandblast API Key Already Configured! ['$cp_sb_key']:'
fi


echo '======================= AWS =========================='

if [ -f "$HOME/.aws/credentials" ]; then
    echo 'AWS Credentials: Good'
else
    echo 'AWS Credentials: Not configured! Run #aws configure'
fi

echo '====================== Azure ========================='

if [ -f "$HOME/.azure/azureProfile.json" ]; then
    echo 'Azure Credentials: Good'
else
    echo 'Azure Credentials: Not configured! Run #az configure'
fi


echo 'Configuring Environement Variables'

mgmt_url="https://$mgmt_ip/web_api/"
gw_ia_url="https://$gw_ip/_IA_API/"
gw_url="https://$gw_ip/rest/"

#Set Session Environment Variables
export cp_mgmt_ip=$mgmt_ip
export cp_mgmt_url=$mgmt_url
export cp_mgmt_user=$mgmt_user
export cp_mgmt_pass=$mgmt_pass
export cp_mgmt_fingerprint=$mgmt_fingerprint
export cp_gw_ip=$gw_ip
export cp_gw_user=$gw_user
export cp_gw_pass=$gw_pass
export cp_gw_url=$gw_url
export cp_gw_ia_url=$gw_ia_url
export cp_gw_ia_pass=$gw_ia_pass
export cp_sb_key=$sb_key
export cp_gw_role=$cp_gw_role
export AWS_REGION=$aws_region

#Backup existing .profile
cp -f $HOME/.profile $HOME/.profile.backup

#Save Environment Variables in .profile
echo "" $HOME/.profile
echo "export cp_mgmt_ip="$mgmt_ip >> $HOME/.profile
echo "export cp_mgmt_url="$mgmt_url >> $HOME/.profile
echo "export cp_mgmt_user="$mgmt_user >> $HOME/.profile
echo "export cp_mgmt_pass="$mgmt_pass >> $HOME/.profile
echo "export cp_mgmt_fingerprint="$mgmt_fingerprint >> $HOME/.profile
echo "export cp_gw_ip="$gw_ip >> $HOME/.profile
echo "export cp_gw_user="$gw_user >> $HOME/.profile
echo "export cp_gw_pass="$gw_pass >> $HOME/.profile
echo "export cp_gw_url="$gw_url >> $HOME/.profile
echo "export cp_gw_ia_url="$gw_ia_url >> $HOME/.profile
echo "export cp_gw_ia_pass="$gw_ia_pass >> $HOME/.profile
echo "export cp_sb_key="$sb_key >> $HOME/.profile
echo "export cp_gw_role="$cp_gw_role >> $HOME/.profile
echo "export AWS_REGION="$aws_region >> $HOME/.profile

#Set Ansible Check Point Hosts for Training

sudo echo "" >> /etc/ansible/hosts
sudo echo "[CheckPoint]" >> /etc/ansible/hosts
sudo echo $cp_mgmt_ip" ansible_user=admin ansible_python_interpreter=/opt/CPsuite-R80/fw1/Python/bin/python" >> /etc/ansible/hosts
sudo echo $cp_gw_ip" ansible_user=admin ansible_python_interpreter=/opt/CPsuite-R80/fw1/Python/bin/python" >> /etc/ansible/hosts

echo 'Complete, Please log out and back in'

