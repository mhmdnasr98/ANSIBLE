provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "Jenkins-sg" {
  name        = "Jenkins-Security Group"
  description = "Open 22,443,80,8080"

  ingress = [
    for port in [22, 80, 443, 8080] : {
      description      = "TLS from VPC"
      from_port        = port
      to_port          = port
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Jenkins-sg"
  }
}

resource "aws_instance" "web" {
  ami                    = "ami-0e001c9271cf7f3b9"
  instance_type          = "t2.medium"
  key_name               = "ansible-control-key"
  vpc_security_group_ids = [aws_security_group.Jenkins-sg.id]

  user_data = <<-EOF
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
    cd /Ansible/installations

    # Run the playbook
    ansible-playbook Jenkins-playbook.yml
  EOF

  tags = {
    Name = "Jenkins-server"
  }

  root_block_device {
    volume_size = 8
  }
}
