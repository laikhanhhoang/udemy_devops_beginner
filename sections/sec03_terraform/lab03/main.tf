provider "aws" {
  region = var.region
}

resource "aws_key_pair" "udemy-keypair" {
  key_name   = "udemy-keypair"
  public_key = file("./keypair/udemy-key.pub")
}

resource "aws_instance" "demo-instance" {
  ami           = var.ami_chosen[var.region]
  instance_type = var.instance_type
  key_name      = aws_key_pair.udemy-keypair.key_name
  tags = {
    Name = "Udemy Demo"
  }
  vpc_security_group_ids = [aws_security_group.test-security-group.id]
}

resource "aws_security_group" "test-security-group" {
  name        = "test-security-group"
  description = "test-security-group"

  # Define the VPC for the SG if you have a custom VPC, if not it will use default VPC of the region
  # vpc_id = aws_vpc.<your_custom_vpc_name>.id
  # In this lab, the vpc_id is not defined, so it will make it the default VPC of THIS region

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

