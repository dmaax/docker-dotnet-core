resource "aws_subnet" "public_subnet" {
  vpc_id                  = var.vpc_id # Use the variable
  cidr_block              = var.public_cidr_block
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags = {
    Name = "coodesh_public_subnet"
  }
}

# modules/subnet/main.tf
resource "aws_subnet" "private_subnet" {
  vpc_id                  = var.vpc_id # Use the variable
  cidr_block              = var.private_cidr_block
  map_public_ip_on_launch = false
  availability_zone       = "us-east-1b"

  tags = {
    Name = "coodesh_private_subnet"
  }
}