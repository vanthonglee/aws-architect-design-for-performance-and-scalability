# Designate a cloud provider, region, and credentials
provider "aws" {
  access_key = "ASIASFDPZQUQ3U7CZB5D"
  secret_key = "IUC0+a8lhEb25YWcN81oMHMlvsScGjI9rJxbLWPh"
  token = "FwoGZXIvYXdzELX//////////wEaDLfj0BGu3Nus0BrYDCLVATNcJkGiQFM47k3ZWK4ntJ2SAa0BOiwo3yy2ho5I1n4B/iJpZ8bv4a54u4xVhhOBKVY/5a167VEVH50YXSDnx11F2Rg950WRHhr69ifZm9d/nsBHglLsDoCnw9wy+Ncles0+vrnaJL1fJ1L1xmyUWwkF8l1pjQnnhLEexqYjwpeZ91PgMviEDjVCul8c748Sab78X+ZV38Rk6kjJkT5FBPrtNXq8n6CbFHt9zWz4DcgUuMQdRctIqGavwmol00C91xUCai7L5P2S3O0VtJ94r+n1NHESOijdoYKmBjItlaL3a8GnAooPtBNEwKyOD+F+Mv46bPwjKLz3JF8zkNZ1HwEhM7MaehhnKJyu"
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