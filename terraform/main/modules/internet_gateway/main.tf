resource "aws_internet_gateway" "coodesh_igw" {
  vpc_id = var.vpc_id

  tags = {
    Name = "coodesh_igw"
  }
}