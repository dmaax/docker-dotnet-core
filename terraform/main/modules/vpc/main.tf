resource "aws_vpc" "coodesh_vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "coodesh-vpc"
  }
}