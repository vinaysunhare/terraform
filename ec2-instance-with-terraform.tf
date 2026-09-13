terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.66.0"
    }
  }
}

provider "aws" {
  # We use AWS now
  region = "us-east-1" # We will create the EC2 instance in us-east-1
}

resource "aws_instance" "vinaywebserver" {
  ami           = "ami-0e86e20dae9224db8" # AMI ID - our Linux image
  instance_type = "t2.micro"              # We use the free-tier t2.micro

  tags = {
    Name = "vinay-ec2-instance-with-terraform" # EC2 instance name
  }
}