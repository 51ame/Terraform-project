#!/bin/bash
cd /home/ubuntu/

WIREGUARD_SERVER_IP=$(aws ec2 describe-instances   --filter "Name=instance-state-name,Values=running"   --query "Reservations[*].Instances[*].[PublicIpAddress, Tags[?Key=='Name'].Value|[0]]"   --output text | grep Wireguard | awk '{print $1}')
BASTION_SERVER_IP=$(aws ec2 describe-instances   --filter "Name=instance-state-name,Values=running"   --query "Reservations[*].Instances[*].[PublicIpAddress, Tags[?Key=='Name'].Value|[0]]"   --output text | grep Bastion | awk '{print $1}')
echo "create hosts.txt"
cat > ./ansible-hosts.txt << EOF
[wireguard]
$WIREGUARD_SERVER_IP
[wireguard:vars]
ansible_user= ubuntu
ansible_ssh_private_key_file= /home/ubuntu/.ssh/51ame-newkey-frankfurt.pem
[bastion]
$BASTION_SERVER_IP
[bastion:vars]
ansible_user= ubuntu
ansible_ssh_private_key_file= /home/ubuntu/.ssh/51ame-newkey-frankfurt.pem
EOF
echo "hosts.txt created, now u can use ansible-playbook command"
