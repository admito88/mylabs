output "data_aws_availability_zone" {
  value = data.aws_availability_zones.working.names
}
output "data_aws_caller_identity" {
  value = data.aws_caller_identity.current.account_id
}
output "data_aws_region" {
  value = data.aws_region.current.description
}
output "aws_vpcs"{
  value = data.aws_vpcs.my_vpcs.ids
}
output "aws_vpc_id"{
  value = data.aws_vpc.prod_vpc.id
}
output "aws_vpc_cidr"{
  value = data.aws_vpc.prod_vpc.cidr_block
}
