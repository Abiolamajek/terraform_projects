# Creating Security Group for ASG Launch Template
resource "aws_security_group" "black-sg" {
  name   = "black team for ASG"
  vpc_id = "vpc-0600f87f4ea1cf6f8"

  # Inbound Rules
  # HTTP access from anywhere
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    #security_groups = [aws_security_group.alb-sg.id]
  }

  # SSH access from anywhere
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    #security_groups = [aws_security_group.alb-sg.id]
  }

  # Outbound Rules
  # Internet access to anywhere
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
