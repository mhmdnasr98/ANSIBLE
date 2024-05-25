#!/bin/bash
exec > >(tee -i /var/log/user-data.log)
exec 2>&1

# Update apt package lists
sudo apt update -y

# Install required software
sudo apt install -y software-properties-common
sudo apt install -y ansible git

# Clone the Ansible playbook repository
mkdir Ansible
cd Ansible
git clone https://github.com/mhmdnasr98/installitions.git

# Run Ansible playbook
cd installitions
ansible-playbook -i localhost Jenkins-playbook.yml
