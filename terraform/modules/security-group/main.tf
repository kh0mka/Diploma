resource "aws_security_group" "sg" {
  vpc_id = var.vpc_id

  dynamic "ingress" {
    for_each = var.dynamic_ingress
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, lookup(var.tags_for_resource, "aws_sg", {}))
}
