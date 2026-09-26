output "vpc_id" {
  description = "ID of the created VPC."
  value       = aws_vpc.this.id
}

output "vpc_cidr" {
  description = "CIDR block of the VPC."
  value       = aws_vpc.this.cidr_block
}

output "internet_gateway_id" {
  description = "ID of the internet gateway."
  value       = aws_internet_gateway.this.id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets."
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "IDs of the private subnets."
  value       = aws_subnet.private[*].id
}

output "public_route_table_id" {
  description = "ID of the public route table."
  value       = aws_route_table.public.id
}

output "private_route_table_ids" {
  description = "IDs of the private route tables."
  value       = aws_route_table.private[*].id
}

output "availability_zones" {
  description = "Availability Zones configured for this network."
  value       = var.availability_zones
}

output "flow_log_group_name" {
  description = "CloudWatch Log Group receiving VPC Flow Logs."
  value       = aws_cloudwatch_log_group.vpc_flow_logs.name
}
