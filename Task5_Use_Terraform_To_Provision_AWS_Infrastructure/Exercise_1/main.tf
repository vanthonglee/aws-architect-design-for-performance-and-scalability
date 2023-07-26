# Designate a cloud provider, region, and credentials
provider "aws" {
  access_key = "xxx"
  secret_key = "xxx"
  token = "xxx"
  region = "us-east-1"  # Replace with your desired AWS region
}

# Provision 4 AWS t2.micro EC2 instances named Udacity T2
resource "aws_instance" "udacity_t2" {
  count         = 4
  ami           = var.aws_ami  # Replace with your desired AMI ID
  instance_type = "t2.micro"
  subnet_id     = var.existing_public_subnet_id
  tags = {
    Name = "Udacity T2"
  }
}

# Provision 2 m4.large EC2 instances named Udacity M4
resource "aws_instance" "udacity_m4" {
  count         = 2
  ami           = var.aws_ami  # Replace with your desired AMI ID
  instance_type = "m4.large"
  subnet_id     = var.existing_public_subnet_id
  tags = {
    Name = "Udacity M4"
  }
}