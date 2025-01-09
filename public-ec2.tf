# Security Group for EC2 instances
resource "aws_security_group" "ec2_sg" {
  name        = "ec2-security-group"
  description = "Security group for EC2 instances"
  vpc_id      = module.network.vpc_id

  # Allow HTTP from the load balancer security group
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    cidr_blocks = [var.allow_all]
    security_groups = [aws_security_group.lb_sg.id]
  }

  # Allow HTTPS from the load balancer security group
  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    cidr_blocks = [var.allow_all]
    security_groups = [aws_security_group.lb_sg.id]
  }

  # Allow SSH from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allow_all]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.allow_all]
  }

  tags = {
    Name = "ec2-security-group"
  }
}

# EC2 instance in public subnet 1a
resource "aws_instance" "ec2_1a" {
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = module.network.public_subnet1_id
  vpc_security_group_ids      = [aws_security_group.ec2_sg.id]
  associate_public_ip_address = true
  key_name                   = var.key_name

  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y apache2
              systemctl start apache2
              systemctl enable apache2
              echo "<h1>Hello from EC2 in AZ 1a</h1>" > /var/www/html/index.html
              EOF

  tags = {
    Name = "ec2-instance-1a"
  }
}

# EC2 instance in public subnet 1b
resource "aws_instance" "ec2_1b" {
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = module.network.public_subnet2_id
  vpc_security_group_ids      = [aws_security_group.ec2_sg.id]
  associate_public_ip_address = true
  key_name                   = var.key_name

  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y apache2
              systemctl start apache2
              systemctl enable apache2
              echo "<h1>Hello from EC2 in AZ 1b</h1>" > /var/www/html/index.html
              EOF

  tags = {
    Name = "ec2-instance-1b"
  }
}

# Target Group Attachment for EC2 in 1a
resource "aws_lb_target_group_attachment" "ec2_1a" {
  target_group_arn = aws_lb_target_group.main.arn
  target_id        = aws_instance.ec2_1a.id
  port             = 80
}

# Target Group Attachment for EC2 in 1b
resource "aws_lb_target_group_attachment" "ec2_1b" {
  target_group_arn = aws_lb_target_group.main.arn
  target_id        = aws_instance.ec2_1b.id
  port             = 80
}
