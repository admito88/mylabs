provider "aws" {
region = "eu-central-1"
}

resource "aws_instance" "web_1" {
  ami = "ami-0dcc0ebde7b2e00db"
  instance_type = "t2.micro"
  security_groups =  ["Linux_http_ssh"]
  user_data = file("apache_install.sh")
tags = {
  Name = "Test_apache"
}
lifecycle {
#prevent_destroy = true
#ignore_changes = ["ami", "user_data"]
create_before_destroy = true
}
}


resource "aws_instance" "web_2" {
  ami = "ami-0dcc0ebde7b2e00db"
  instance_type = "t2.micro"
  security_groups =  ["Linux_http_ssh"]
depends_on = [aws_instance.web_1]
}


resource "aws_instance" "web_3" {
  ami = "ami-0dcc0ebde7b2e00db"
  instance_type = "t2.micro"
  security_groups =  ["Linux_http_ssh"]
depends_on = [aws_instance.web_1, aws_instance.web_2]
}


resource "aws_subnet" "prod_subnet_1" {
    vpc_id = data.aws_vpc.prod_vpc.id
    availability_zone = data.aws_availability_zones.working.names[0]
    cidr_block = "172.31.5.0/24"
    tags = {
      Name = "Subnet_1 in ${data.aws_availability_zones.working.names[0]}"
      Account = "Subnet in ${data.aws_caller_identity.current.account_id}"
      Region = data.aws_region.current.description
    }
}

resource "aws_subnet" "prod_subnet_2" {
    vpc_id = data.aws_vpc.prod_vpc.id
    availability_zone = data.aws_availability_zones.working.names[1]
    cidr_block = "172.31.6.0/24"
    tags = {
      Name = "Subnet_2 in ${data.aws_availability_zones.working.names[1]}"
      Account = "Subnet in ${data.aws_caller_identity.current.account_id}"
      Region = data.aws_region.current.description
    }
}
