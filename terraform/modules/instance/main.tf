data "aws_ami" "latest_ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-arm64-server-*"]
  }

  owners = ["099720109477"]
}

resource "aws_eip" "web-srv-eip" {
  count = var.instance_count

  instance = element(aws_instance.instance_of_web_server.*.id, count.index)
  domain   = "vpc"
}

resource "aws_instance" "instance_of_web_server" {
  count = var.instance_count

  ami                         = data.aws_ami.latest_ubuntu.id
  key_name                    = element(aws_key_pair.deployvm.*.key_name, count.index)
  associate_public_ip_address = true
  instance_type               = var.instance_type
  vpc_security_group_ids      = var.vpc_security_group_ids
  subnet_id                   = element(var.subnet_id, count.index)
  iam_instance_profile        = var.iam_instance_profile

  connection {
    type = "ssh"
    host = self.public_ip
    user = "ubuntu"
    private_key = var.private_key
    timeout = "3m"
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = merge(var.tags, lookup(var.tags_for_resource, "aws_web_instance", {}))
}

resource "aws_key_pair" "deployvm" {
  count = var.instance_count

  key_name = element(var.key_name, count.index)
  public_key = element(var.public_key, count.index)
}
