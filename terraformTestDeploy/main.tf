terraform {
  required_providers {
    aws = {
        source = "registry.terraform.io/hashicorp/aws"
        version = "~> 4.0"
    }
  }
  backend "s3" {
    key = "aws/ec2-deploy/terraform.tfstate"
  }
}

provider "aws" {
    region = var.aws_region
}

data "aws_ami" "latest_ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-arm64-server-*"]
  }

  owners = ["099720109477"]
}


resource "aws_eip" "web-srv-eip" {
  instance = aws_instance.webservice_host.id
  domain   = "vpc"
}

resource "aws_instance" "webservice_host" {
  ami                         = data.aws_ami.latest_ubuntu.id
  associate_public_ip_address = true
  instance_type               = var.instance_type
  vpc_security_group_ids      = var.vpc_security_group_ids
  subnet_id                   = element(var.subnet_id, count.index)
  iam_instance_profile        = var.iam_instance_profile

  lifecycle {
    create_before_destroy = true
  }
}