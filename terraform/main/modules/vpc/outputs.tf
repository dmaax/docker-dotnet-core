output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.it_vpc.id
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = aws_vpc.it_vpc.cidr_block
}

output "arn" {
  description = "ARN of vpc"
  value       = aws_vpc.it_vpc.arn
}