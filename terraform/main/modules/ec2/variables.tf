variable "vpc_id" {
  description = "The VPC ID where subnets will be created"
  type        = string
}

variable "ami_id" {
  description = "The AMI ID to be used for the EC2 instance."
  type        = string
}

variable "instance_type" {
  description = "The type of EC2 instance to use."
  type        = string
} 

variable "key_name" {
  description = "The key name of the AWS Key Pair to be used for the EC2 instance."
  type        = string
}

variable "public_key" {
  description = "The public key to be used for the AWS Key Pair."
  type        = string
  default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII01u9/XeNW3qOLLmo/AM46laLPXz0ALUpcsUVmFVIbH dmaax@teste"
}

variable "security_group_id" {
  description = "The ID of the security group to be used for the EC2 instance."
  type        = string
}

variable "public_subnet_id" {
  description = "The ID of the public subnet where the EC2 instance will be created."
  type        = string
}