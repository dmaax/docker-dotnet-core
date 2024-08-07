output "public_route_table_id" {
  value = aws_route_table.coodesh_public_route_table.id
}

output "private_route_table_id" {
  value = aws_route_table.coodesh_private_route_table.id
}