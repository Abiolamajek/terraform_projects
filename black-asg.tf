# Create an autoscaling group with the specified configurations
resource "aws_autoscaling_group" "asg" {
  name                = "my-asg"
  min_size            = 2
  max_size            = 5
  desired_capacity    = 2
  availability_zones = ["us-west-1a"]
  launch_template {
    id = aws_launch_template.black-asg.id
  }

  # Tag the autoscaling group for easier identification
  tag {
    key                 = "Name"
    value               = "my Black ASG"
    propagate_at_launch = true
  }
}

# Create a launch template with the specified configurations
resource "aws_launch_template" "black-asg" {
  name                   = "my-black-asg"
  image_id               = var.ami_id
  instance_type          = var.instance
  key_name               = var.key
  vpc_security_group_ids = [aws_security_group.black-sg.id]
  user_data              = filebase64("${path.root}/install_apache.sh")
}
