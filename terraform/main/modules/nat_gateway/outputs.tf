output "nat_gateway_id" {
  value = aws_nat_gateway.it_nat_gateway.id
}

output "nat_gateway_eip" {
  value = aws_eip.it_nat_gateway.public_ip
}