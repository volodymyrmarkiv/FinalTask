#!/usr/bin/env bash

user="ec2-user"

# Update yum cache
sudo yum update -y

# Enable epel repository
sudo amazon-linux-extras install epel -y
sudo yum-config-manager --enable epel

# Install ansible
sudo yum install -y ansible

# Create dir for ansible configuration
mkdir /home/$user/ansible

# Change path to ansible inventory
sudo sed -i s'/#inventory\ \ \ \ \ \ \=\ \/etc\/ansible\/hosts/inventory\ \ \ \ \ \ =\ \/home\/ec2-user\/ansible\/hosts/' /etc/ansible/ansible.cfg

# Add ansible hosts to inventory file
cat  <<EOF >> /home/$user/ansible/hosts
[cicd]
AmazonLinux ansible_host=172.31.0.10 ansible_user=ec2-user ansible_ssh_private_key_file=/home/ec2-user/.ssh/FinalTaskEPAM.pem

[web-server]
AmazonLinux2 ansible_host=172.31.0.11 ansible_user=ec2-user ansible_ssh_private_key_file=/home/ec2-user/.ssh/FinalTaskEPAM.pem

[build]
AmazonLinux3 ansible_host=172.31.0.12 ansible_user=ec2-user ansible_ssh_private_key_file=/home/ec2-user/.ssh/FinalTaskEPAM.pem
EOF
