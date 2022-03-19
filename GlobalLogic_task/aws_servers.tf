provider "aws" {
region = "eu-central-1"
}

resource "aws_instance" "jenkins_server" {
ami = "ami-0dcc0ebde7b2e00db"
instance_type = "t2.micro"
user_data = <<EOF
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
key_name = "Amazon_linux"
}

resource "aws_instance" "jenkins_server" {
ami = "ami-0dcc0ebde7b2e00db"
instance_type = "t2.micro"
user_data = <<EOF
#!/bin/bash
yum update -y
yum upgrade
EOF
key_name = "Amazon_linux"
}
