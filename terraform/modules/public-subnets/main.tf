resource "aws_subnet" "public_subnet" {
  count = var.subnet_count

  vpc_id                  = var.vpc_id
  cidr_block              = element(var.cidr_block, count.index)
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = var.map_public_ip_on_launch

  tags = merge(var.tags, lookup(var.tags_for_resource, "aws_public_subnet",
    {
      "Name"        = "Public Subnet #${count.index + 1}"
      "Description" = "Public Subnet"
      "Section"     = "Terraform"
      "Task"        = "3"
  }))
}

resource "aws_route_table" "public_subnet_route_table" {
  # count = var.subnet_count

  vpc_id = var.vpc_id

  tags = merge(var.tags, lookup(var.tags_for_resource,
    "aws_public_subnet_route_table",
    {
      "Name"        = "Route table of Public Subnets"
      "Description" = "Route Table with IGW for Public Subnet"
      "Section"     = "Terraform"
      "Task"        = "3"
  }))
}

resource "aws_route" "internet_gateway" {
  count = var.subnet_count

  destination_cidr_block = "0.0.0.0/0"
  route_table_id         = element(aws_route_table.public_subnet_route_table.*.id, count.index)
  gateway_id             = var.gateway_id
}

resource "aws_route_table_association" "default" {
  count = var.subnet_count

  subnet_id      = element(aws_subnet.public_subnet.*.id, count.index)
  route_table_id = aws_route_table.public_subnet_route_table.id
  # For each subnet creating route table
  # route_table_id = element(aws_route_table.public_subnet_route_table.*.id, count.index)
}
