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
