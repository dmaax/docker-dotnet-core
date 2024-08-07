output "public_ip" {
  value = aws_instance.coodesh_vm.public_ip
}

output "public_dns" {
  value = aws_instance.coodesh_vm.public_dns
}

output "private_ip" {
  value = aws_instance.coodesh_vm.private_ip
}

output "private_dns" {
  value = aws_instance.coodesh_vm.private_dns
}