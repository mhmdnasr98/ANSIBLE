#!/bin/bash
apt-get update -y
apt-get upgrade -y

# Install Ansible and git
apt-get install -y software-properties-common
apt-add-repository --yes --update ppa:ansible/ansible
apt-get update -y
apt-get install -y ansible git

# Create the directory if it doesn't exist
mkdir -p /Ansible

# Change to the correct directory
cd /Ansible

# Clone the repository
git clone https://github.com/mhmdnasr98/installations.git

# Navigate to the cloned repository
cd installations

# Run the playbook
ansible-playbook Jenkins-playbook.yml
