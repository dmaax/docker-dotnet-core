resource "aws_instance" "coodesh_vm" {
  ami           = var.ami_id
  instance_type = var.instance_type

  key_name        = var.key_name
  subnet_id       = var.public_subnet_id
  security_groups = [var.security_group_id]

  # Associate a public ip address
  associate_public_ip_address = true

  tags = {
    Name = "coodesh_vm"
  }
}

resource "aws_key_pair" "my_key" {
  key_name   = var.key_name
  public_key = var.public_key
}
