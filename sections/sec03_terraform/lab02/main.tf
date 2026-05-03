provider "aws" {
  region = "ap-southeast-2"
}

data "aws_vpc" "default" {
  default = true
}

resource "aws_key_pair" "lab-keypair" {
  key_name   = "udemy-devops-sec03-lab02-key"
  public_key = file("./keypair/udemy-devops-sec03-lab02-key.pub")
}

resource "aws_security_group" "lab-sg" {
  name        = "udemy-devops-sec03lab02-security-group"
  description = "udemy-devops-sec03lab02-security-group"

  vpc_id      = data.aws_vpc.default.id

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

resource "aws_instance" "lab-instance" {
  ami           = "ami-0178a018dd21c1745" # ami-082b6a99fff8987dc (Base AMI)
  instance_type = "t3.micro"
  key_name      = aws_key_pair.lab-keypair.key_name
  tags = {
    Name = "Udemy DevOps Lab02 Instance"
    Domain = "DevOps"
  }
  vpc_security_group_ids = [aws_security_group.lab-sg.id]
}



