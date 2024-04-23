terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.0"
    }
  }
  backend "s3" {
    key = "my-terraform-project"
    bucket = "storebackends3bucket"
    region = "eu-north-1"
    access_key = "AKIAVRUVU2KEHVYTSLSP"
    secret_key = "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"
  }
}

provider "aws" {
  region = var.aws_region
  access_key = "AKIAVRUVU2KEHVYTSLSP"
  secret_key = "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"
}

module "vpc" {
  source = "./modules/vpc"

  cidr_block = var.vpc_cidr_block

  tags              = var.tags
  tags_for_resource = var.tags_for_resource
}

module "public_subnets" {
  source = "./modules/public-subnets"

  vpc_id                  = module.vpc.get_vpc_id
  gateway_id              = module.vpc.get_internet_gateway_id
  map_public_ip_on_launch = var.map_public_ip_on_launch

  cidr_block        = var.public_cidr_block
  subnet_count      = var.public_subnet_count
  availability_zone = "eu-north-1a"

  tags              = var.tags
  tags_for_resource = var.tags_for_resource
}

module "sg" {
  vpc_id = module.vpc.get_vpc_id

  source = "./modules/security-group"

  dynamic_ingress = ["22", "3000"]
}

module "instance" {
  source = "./modules/instance"

  instance_count         = 1
  instance_type          = "t3.micro"
  subnet_id              = module.public_subnets.get_subnet_ids
  vpc_security_group_ids = module.sg.sg_id
  iam_instance_profile   = module.cloudwatch.IAMInstanceProfileRoleName
}

module "cloudwatch" {
  source    = "./modules/cloudwatch"
  subnet_id = module.public_subnets.get_subnet_ids[0]
}