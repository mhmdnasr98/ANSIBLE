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

# Check if the directory was created successfully
if [ -d "/Ansible" ]; then
  echo "Directory /Ansible created successfully."
else
  echo "Failed to create directory /Ansible."
  exit 1
fi

# Change to the correct directory
cd /Ansible

# Clone the repository
git clone https://github.com/mhmdnasr98/installations.git

# Check if the repository was cloned successfully
if [ -d "/Ansible/installations" ]; then
  echo "Repository cloned successfully."
else
  echo "Failed to clone repository."
  exit 1
fi

# Navigate to the cloned repository
cd /Ansible/installations

# Run the playbook
ansible-playbook Jenkins-playbook.yml
