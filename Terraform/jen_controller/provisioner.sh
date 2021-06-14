#!/usr/bin/env bash

user="ec2-user"

# Update yum cache
sudo yum update -y

# Enable epel repository
sudo amazon-linux-extras install epel -y
sudo yum-config-manager --enable epel

# Install ansible
sudo yum install -y ansible

# Change path to ansible inventory
sudo sed -i s'/#inventory\ \ \ \ \ \ =\ \/etc\/ansible\/hosts/inventory\ \ \ \ \ \ =\ \/home\/ec2-user\/ansible\/hosts/' /etc/ansible/ansible.cfg

# Disable ssh connection approval
sudo sed -i s'/#host_key_checking\ =\ False/host_key_checking\ =\ False/' /etc/ansible/ansible.cfg

# Install Git
sudo yum install -y git

# Create id_rsa for github without asking questions
ssh-keygen -t rsa -f /home/$user/.ssh/id_rsa -q -P ""

# Add necessary rights to file
sudo chmod 400 /home/$user/.ssh/FinalTaskEPAM.pem
sudo chown $user:$user /home/$user/.ssh/FinalTaskEPAM.pem

# Copy id_rsa to other instances
scp -i /home/$user/.ssh/FinalTaskEPAM.pem -o StrictHostKeyChecking=no /home/$user/.ssh/id_rsa $user@172.31.0.12:/home/$user/.ssh
scp -i /home/$user/.ssh/FinalTaskEPAM.pem -o StrictHostKeyChecking=no /home/$user/.ssh/id_rsa $user@172.31.0.11:/home/$user/.ssh

# Add github to known_hosts
ssh -o StrictHostKeyChecking=no -T git@github.com &>/dev/null

# Create dir for ansible configuration
mkdir /home/$user/ansible

# Add ansible hosts to inventory file
cat  <<EOF >> /home/$user/ansible/hosts
[cicd]
AmazonLinux ansible_host=172.31.0.10 ansible_user=ec2-user ansible_ssh_private_key_file=/home/ec2-user/.ssh/FinalTaskEPAM.pem

[web-server]
AmazonLinux2 ansible_host=172.31.0.11 ansible_user=ec2-user ansible_ssh_private_key_file=/home/ec2-user/.ssh/FinalTaskEPAM.pem

[build]
AmazonLinux3 ansible_host=172.31.0.12 ansible_user=ec2-user ansible_ssh_private_key_file=/home/ec2-user/.ssh/FinalTaskEPAM.pem

[test]
AmazonLinux4 ansible_host=172.31.0.13 ansible_user=ec2-user ansible_ssh_private_key_file=/home/ec2-user/.ssh/FinalTaskEPAM.pem
EOF