provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "jenkins_server" {
  ami           = "ami-0dcc0ebde7b2e00db"
  instance_type = "t2.micro"
  user_data     = <<EOF
#!/bin/bash
yum update –y
wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
yum upgrade
amazon-linux-extras install java-openjdk11 -y
yum install jenkins -y
systemctl enable jenkins
systemctl start jenkins
EOF
  key_name      = "Amazon_linux"
  tags = {
    Name = "jenkins_server"
  }
  vpc_security_group_ids = [aws_security_group.jenkins_server.id]
}

resource "aws_instance" "kvm_server" {
  ami           = "ami-0dcc0ebde7b2e00db"
  instance_type = "t2.micro"
  user_data     = <<EOFstall jenkins -y
systemctl enable jenkins
systemctl start jenkins
EOF
  key_name      = "Amazon_linux"
  tags = {
    Name = "jenkins_server"
  }
  vpc_security_group_ids = [aws_security_group.jenkins_server.id]
}

resource "aws_instance" "kvm_server" {
  ami           = "ami-0dcc0ebde7b2e00db"
  instance_type = "t2.micro"
  user_data     = <<EOF
#!/bin/bash
yum update -y
yum upgrade
#!/bin/bash
yum update -y
yum upgrade
EOF
  key_name      = "Amazon_linux"
  tags = {
    Name = "kvm_server"
  }
  vpc_security_group_ids = [aws_security_group.kvm_server.id]
}
resource "aws_security_group" "jenkins_server" {
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "jenkins_server"
  }
}
resource "aws_security_group" "kvm_server" {
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "kvm_server"
  }
}
