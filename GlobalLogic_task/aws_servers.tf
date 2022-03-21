provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "jenkins_server" {
  ami           = "ami-0dcc0ebde7b2e00db"
  instance_type = "t2.micro"
  key_name      = "Amazon_linux"
  tags = {
    Name = "jenkins_server"
  }
  vpc_security_group_ids = [aws_security_group.jenkins_server.id]
  network_interface {
    network_interface_id = aws_network_interface.jenkins_server.id
    device_index         = 0
  }
}

resource "aws_instance" "kvm_server" {
  ami           = "ami-0dcc0ebde7b2e00db"
  instance_type = "t2.micro"
  key_name      = "Amazon_linux"
  tags = {
    Name = "kvm_server"
  }
  vpc_security_group_ids = [aws_security_group.kvm_server.id]
  network_interface {
    network_interface_id = aws_network_interface.kvm_server.id
    device_index         = 0
  }
}

resource "aws_instance" "HAproxy" {
  ami           = "ami-0dcc0ebde7b2e00db"
  instance_type = "t2.micro"
  key_name      = "Amazon_linux"
  tags = {
    Name = "HAproxy_server"
  }
  vpc_security_group_ids = [aws_security_group.HAproxy_server.id]
  network_interface {
    network_interface_id = aws_network_interface.HAproxy_server.id
    device_index         = 0
  }

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
    Name = "HAproxy_server"
  }
}

resource "aws_vpc" "Global_logic_task" {
  cidr_block = "172.32.0.0/16"
  tags = {
    Name = "Global_logic_task"
  }
}

resource "aws_internet_gateway" "Global_logic_task" {
  vpc_id = aws_vpc.Global_logic_task.id
  tags = {
    Name = "Global_logic_task"
  }
}

resource "aws_route_table" "Global_logic_task" {
  vpc_id = aws_vpc.Global_logic_task.id

  route {
    cidr_block = "172.32.10.0/24"
    gateway_id = aws_internet_gateway.Global_logic_task.id
  }
  tags = {
    Name = "Global_logic_task"
  }
}

resource "aws_subnet" "Global_logic_task" {
  vpc_id     = aws_vpc.Global_logic_task.id
  cidr_block = "172.32.10.0/24"
  tags = {
    Name = "Global_logic_task"
  }
}

resource "aws_route_table_association" "Global_logic_task" {
  subnet_id      = aws_subnet.Global_logic_task.id
  route_table_id = aws_route_table.Global_logic_task.id
}

resource "aws_network_interface" "jenkins_server" {
  subnet_id       = aws_subnet.Global_logic_task.id
  security_groups = [aws_security_group.jenkins_server.id]
  tags = {
    Name = "jenkins_server"
  }
}

resource "aws_network_interface" "kvm_server" {
  subnet_id       = aws_subnet.Global_logic_task.id
  security_groups = [aws_security_group.kvm_server.id]
  tags = {
    Name = "kvm_server"
  }
}

resource "aws_network_interface" "HAproxy_server" {
  subnet_id       = aws_subnet.Global_logic_task.id
  security_groups = [aws_security_group.HAproxy_server.id]
  tags = {
    Name = "HAproxy_server"
  }
}
