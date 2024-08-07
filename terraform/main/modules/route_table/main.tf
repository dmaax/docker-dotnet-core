resource "aws_route_table" "it_public_route_table" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw_id
  }

  tags = {
    Name = "it_public_rt"
  }
}

resource "aws_route_table_association" "it_public_route_table_assoc" {
  subnet_id      = var.public_subnet_id
  route_table_id = aws_route_table.it_public_route_table.id
}

resource "aws_route_table" "it_private_route_table" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = var.nat_gateway_id
  }

  tags = {
    Name = "it_private_rt"
  }
}

resource "aws_route_table_association" "it_private_route_table_assoc" {
  subnet_id      = var.private_subnet_id
  route_table_id = aws_route_table.it_private_route_table.id
}