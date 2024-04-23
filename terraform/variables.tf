# Generic variables

variable "tags" {
  description = "A map of tags to assign to resources"
  type        = map(string)
  default     = {}
}

variable "tags_for_resource" {
  description = "A nested map of tags to assign to specific resource types"
  type        = map(map(string))
  default = {
    aws_vpc = {
      "Name"        = "The main VPC"
      "Description" = "Primary VPC for task"
      "Section"     = "Terraform"
      "Task"        = "4"
    }
  }
}

# VPC variables

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "172.16.0.0/16"
}

# Public subnet variables

variable "public_cidr_block" {
  description = "The larger CIDR block to use for calculating individual public subnet CIDR blocks"
  type        = list(string)
  default     = ["172.16.1.0/24"]
}

variable "public_subnet_count" {
  description = "The number of public subnets to create"
  type        = string
  default     = "1"
}

variable "map_public_ip_on_launch" {
  description = "Assign a public IP address to instances launched into the public subnets"
  type        = string
  default     = true
}

variable "aws_region" {
  default = "eu-north-1"
}

variable "public_key" {

}

variable "private_key" {

}

variable "key_name" {

}
