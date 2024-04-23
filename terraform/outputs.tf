# VPC outputs

output "vpc_id" {
  description = "The VPC ID"
  value       = module.vpc.get_vpc_id
}

output "internet_gateway_id" {
  description = "The Internet Gateway ID"
  value       = module.vpc.get_internet_gateway_id
}

# Public subnet outputs

output "public_subnet_count" {
  description = "The number of public subnets"
  value       = module.public_subnets.get_subnet_count
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = module.public_subnets.get_subnet_ids
}

output "public_route_table_ids" {
  description = "List of public route table IDs"
  value       = module.public_subnets.get_route_table_ids
}

output "instance_public_ip" {
  value = module.instance.instance_public_ip
  sensitive = true
}
