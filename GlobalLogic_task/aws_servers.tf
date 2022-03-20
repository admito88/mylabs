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
  user_data     = <<EOF
  #!/bin/bash
  yum update -yexport AWS_SECRET_ACCESS_KEY=JRG6iBzcYevirYCVrZT2EKKL0ubKw1uQxmIMK0SQ
  yum upgrade
EOF
  key_name      = "Amazon_linux"
  tags = {
    Name = "kvm_server"
  }
  vpc_security_group_ids = [aws_security_group.jenkins_server.id]
}

resource "aws_instance" "HAproxy" {
  ami           = "ami-0dcc0ebde7b2e00db"
  instance_type = "t2.micro"
  user_data     = <<EOF
#!/bin/bash
yum update -y
yum upgrade
EOF
  key_name      = "Amazon_linux"
  tags = {
    Name = "HAproxy_server"
  }
  vpc_security_group_ids = [aws_security_group.HAproxy_server.id]
}
resource "aws_security_group" "jenkins_server" {
  dynamic "ingress" {
    for_each = ["22", "8080"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
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
  dynamic "ingress" {
    for_each = ["22", "80", "443"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
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

resource "aws_security_group" "HAproxy_server" {
  dynamic "ingress" {
    for_each = ["22", "80", "443", "8080"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
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
