#!/bin/bash
apt-get update -y
apt-get upgrade -y

# Install Ansible and git
apt-get install -y software-properties-common
apt-add-repository --yes --update ppa:ansible/ansible
apt-get update -y
apt-get install -y ansible git

# Clone the repository
cd /Ansible
git clone https://your-repository-url/installations.git

# Navigate to the correct directory
cd installations

# Run the playbook
ansible-playbook Jenkins.yml
