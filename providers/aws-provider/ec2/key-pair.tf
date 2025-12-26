terraform {
  required_providers {
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.1.0"
    }

    local = {
      source  = "hashicorp/local"
      version = "~> 2.5.0"
    }

    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.17.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  access_key = "test"
  secret_key = "test"
  region     = "us-east-1"
}

resource "tls_private_key" "private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "ssh_key" {
  filename = "keys/aws_id_rsa"
  content  = tls_private_key.private_key.private_key_pem
}

# Create a key pair
resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = tls_private_key.private_key.public_key_openssh
}

# Display information about key pair
data "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  depends_on = [aws_key_pair.deployer]
}

output "key_id" {
  value = aws_key_pair.deployer.id
}

output "key_name" {
  value = aws_key_pair.deployer.key_name
}


output "key_fingerprint" {
  value = aws_key_pair.deployer.fingerprint
}
