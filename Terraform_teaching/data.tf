data "aws_availability_zones" "working" {}
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
data "aws_vpcs" "my_vpcs" {}
data "aws_vpc" "prod_vpc" {
  tags = {
    Name = "prod"
  }
}

data "aws_ami" "latest_amazon_ami" {
  owners = ["137112412989"]
  most_recent = true
  filter {
    name = "name"
    value = [""]
  }
}
