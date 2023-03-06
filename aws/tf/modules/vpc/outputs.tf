# VPC
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.network.vpc_id
}

output "private_route_table_ids" {
  description = "List of IDs of private route tables"
  value       = module.network.private_route_table_ids
}

output "private_subnet_ids" {
  description = "List of IDs of private subnets"
  value       = module.network.private_subnets
}

output "private_subnets_cidr_blocks" {
  description = "List of cidr_blocks of private subnets"
  value       = module.network.private_subnets_cidr_blocks
}

output "public_subnet_ids" {
  description = "List of IDs of private subnets"
  value       = module.network.public_subnets
}
