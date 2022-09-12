output "vpc_id" {
  value = aws_vpc.TestVPC.id
}

output "public_subnet_id" {
  value = aws_subnet.public_subnet.id
}

output "route_table_1_id" {
  value = aws_route_table.INT_GW_RT.id
}

output "private_subnet_id" {
  value = aws_subnet.private_subnet.id
}

output "TestElasticIP_id" {
  value = aws_eip.TestElasticIP.id
}

output "route_table_2_id" {
  value = aws_route_table.NAT_RT.id
}