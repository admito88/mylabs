provider "aws" {
region = "eu-central-1"
}
resource "aws_instance" "Amazon_jenkins" {
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
availability_zone = "eu-central-1a"
network_interface {
network_interface_id = aws_network_interface.Amazon_jenkins.id
device_index = 0
}
root_block_device {
volume_size = 8
tags = {
jen_volume1 = "terraform_eu-central-1_root-volume"
}
}
key_name = "Amazon_linux"
tags = {
Jenkins-server1 = "terraform_eu-central-1_instace"
}
}

resource "aws_instance" "Amazon_docker" {
ami = "ami-0dcc0ebde7b2e00db"
instance_type = "t2.micro"
user_data = <<EOF
#!/bin/bash
yum update –y
amazon-linux-extras install docker
service docker start
usermod -a -G docker ec2-user
docker run -d -p 8080:8080 -p 50000:50000 --name jenkins_1 -v jenkins_1:/var/jenkins_home --restart unless-stopped  jenkins/jenkins
EOF
availability_zone = "eu-central-1a"
network_interface {
network_interface_id = aws_network_interface.Amazon_docker.id
device_index = 0
}
root_block_device {
volume_size = 8
tags = {
jen_volume2 = "terraform_eu-central-1_root-volume"
}
}
key_name= "Amazon_linux"
tags = {
Jenkins-server2 = "terraform_eu-central-1_instance"
}
}
resource "aws_security_group" "jenkins_test"{
name = "jenkins_test"

ingress {
from_port = 22
to_port = 22
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}

ingress {
from_port = 443
to_port = 443
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}

ingress {
from_port = 8080
to_port = 8080
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}

egress {
from_port = 0
to_port = 0
protocol = "-1"
cidr_blocks = ["0.0.0.0/0"]
}
vpc_id = aws_vpc.jenkins_vpc.id
tags = {
SG_for_Jenkins = "terraform_eu-central-1_security-group"
}
}

resource "aws_vpc" "jenkins_vpc" {
cidr_block = "172.16.0.0/16"
tags = {
Network_Amazon1 = "terraform_eu-central-1_vpc"
}
}
resource "aws_subnet" "jenkins_subnet" {
vpc_id = aws_vpc.jenkins_vpc.id
cidr_block = "172.16.10.0/24"
availability_zone = "eu-central-1a"
map_public_ip_on_launch = true
tags = {
Network_Amazon1 = "terraform_eu-central-1_subnet"
}
}

resource "aws_internet_gateway" "jenkins_gateway" {
vpc_id = aws_vpc.jenkins_vpc.id
tags = {
Network_Amazon1 = "terraform_eu-central-1_gateway"
}
} 

resource "aws_route_table" "jenkins_route_table" {
vpc_id = aws_vpc.jenkins_vpc.id
tags = {
Network_Amazon1 = "terraform_eu-central-1_route-table"
}
}

resource "aws_route" "jenkins_route" {
route_table_id = aws_route_table.jenkins_route_table.id
destination_cidr_block = "0.0.0.0/0"
gateway_id = aws_internet_gateway.jenkins_gateway.id
depends_on = [
aws_route_table.jenkins_route_table,
aws_internet_gateway.jenkins_gateway
]
}

resource "aws_route_table_association" "jenkins_rta" {
subnet_id = aws_subnet.jenkins_subnet.id
route_table_id = aws_route_table.jenkins_route_table.id
}

resource "aws_network_interface" "Amazon_jenkins" {
subnet_id = aws_subnet.jenkins_subnet.id
security_groups = [aws_security_group.jenkins_test.id]
tags = {
Network_Amazon1 = "terraform_eu-central-1_network-interface"
}
}

resource "aws_network_interface" "Amazon_docker" {
subnet_id = aws_subnet.jenkins_subnet.id
security_groups = [aws_security_group.jenkins_test.id]
tags = {
Network_Amazon2 = "terraform_eu-central-1_network-interface"
}
}
