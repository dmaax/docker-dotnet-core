terraform {
  required_version = ">= 1.7.5" # Minimum required version

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}