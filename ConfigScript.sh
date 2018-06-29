#!/bin/bash

source .

clear
echo '====== Automation Training Configuration Script ======'
echo 'This script will configure your automation server for:'
echo 'Management API - Bash, Python, Ansible'
echo 'Gaia API - Bash, Python, Ansible'
echo 'Identity API - Bash, Python'
echo 'Sandblast API - Python'
echo ''
echo ''
echo '=================== Management API ==================='
echo 'Management Server IP [ENTER]:'
read mgmt_ip

echo 'Management Server API User [ENTER]:'
read mgmt_user

echo 'Management Server API User Password [ENTER]:'
read mgmt_pass

echo 'Management Server API Fingerprint (#api fingerprint) [ENTER]:'
read mgmt_fingerprint

echo '================= Gaia/Identity API =================='
echo 'Gateway IP [ENTER]:'
read gw_ip

echo 'Gateway Username (Gaia API) [ENTER]:'
read gw_user

echo 'Gateway Password (Gaia API) [ENTER]:'
read gw_pass

echo 'Gateway Shared Secret (IA API) [ENTER]:'
read gw_ia_pass

echo 'Identity Access Role [ENTER]:'
read cp_gw_role

echo '=================== Sandblast API ===================='
echo 'Sandblast API Key [ENTER]:'
read sb_key

echo 'Configuring Environement Variables'

mgmt_url="https://$mgmt_ip/web_api/"
gw_ia_url="https://$gw_ip/_IA_API/"
gw_url="https://$gw_ip/rest/"

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

echo 'Done!'

