terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.16.2"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-west-1"
}


resource "aws_instance" "black_jenkins" {
  ami           = "ami-073e64e4c237c08ad" # use free tier AMI other than Amazon Linux 2023 AMI as it has some issue insatlling Jenkins
  instance_type = "t2.micro"
  key_name                    = "danny"
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.jenkins-sg.id]
  user_data                   = file("blackteam_jenkins.sh")
  #iam_instance_profile        = aws_iam_instance_profile.s3-jenkins-profile.name

  tags = {
    Name = "Jenkins-Server"
  }
}


#Jenkins Security Group Resource
resource "aws_security_group" "jenkins-sg" {
  name        = "jenkins-sg"
  description = "Allow Port 22 and 8080"

  ingress {
    description = "Allow SSH Traffic"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTPS Traffic"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow 8080 Traffic"
    from_port   = 8080
    to_port     = 8080
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

resource "aws_s3_bucket" "black_bucket_team23" {
  bucket = "jenkins-s3-bucket-black-bucket-team2323"

  tags = {
    Name = "Jenkins-Server"
  }
}


resource "aws_s3_bucket_acl" "s3_bucket_acl" {
  bucket = aws_s3_bucket.black_bucket_team23.id
  acl    = "private"
  depends_on = [aws_s3_bucket_ownership_controls.s3_bucket_acl_ownership]
}

# Resource to avoid error "AccessControlListNotSupported: The bucket does not allow ACLs"
resource "aws_s3_bucket_ownership_controls" "s3_bucket_acl_ownership" {
  bucket = aws_s3_bucket.black_bucket_team23.id
  rule {
    object_ownership = "ObjectWriter"
  }
}
