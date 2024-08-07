resource "aws_internet_gateway" "it_igw" {
  vpc_id = var.vpc_id

  tags = {
    Name = "it_igw"
  }
}