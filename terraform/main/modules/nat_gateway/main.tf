resource "aws_eip" "nat_gateway_ip" {
  domain = "vpc"

  tags = {
    Name = "coodesh_nat_gateway_eip"
  }
}

resource "aws_nat_gateway" "coodesh_nat_gateway" {
  allocation_id = aws_eip.nat_gateway_ip.id
  subnet_id     = var.public_subnet_id
  tags = {
    Name = "coodesh_nat_gateway"
  }
}