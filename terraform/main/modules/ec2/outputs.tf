output "public_ip" {
  value = aws_instance.it_vm.public_ip
}

output "public_dns" {
  value = aws_instance.it_vm.public_dns
}

output "private_ip" {
  value = aws_instance.it_vm.private_ip
}

output "private_dns" {
  value = aws_instance.it_vm.private_dns
}