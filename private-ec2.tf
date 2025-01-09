# Security Group for Private EC2 instances
resource "aws_security_group" "private_ec2_sg" {
  name        = "private-ec2-security-group"
  description = "Security group for Private EC2 instances"
  vpc_id      = module.network.vpc_id

  # Allow SSH from public subnet 1a (for bastion host)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.private_subnet1_cidr]
    description = "Allow SSH from public subnet 1a"
  }

  # Allow SSH from public subnet 1b (for bastion host)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.private_subnet2_cidr]
    description = "Allow SSH from public subnet 1b"
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.allow_all]
  }

  tags = {
    Name = "private-ec2-security-group"
  }
}

# EC2 instance in private subnet 1a
resource "aws_instance" "private_ec2_1a" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = module.network.private_subnet1_id
  vpc_security_group_ids = [aws_security_group.private_ec2_sg.id]
  key_name              = var.key_name

  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y apache2
              systemctl start apache2
              systemctl enable apache2
              echo "<h1>Hello from Private EC2 in AZ 1a</h1>" > /var/www/html/index.html
              EOF

  tags = {
    Name = "private-ec2-instance-1a"
  }
}

# EC2 instance in private subnet 1b
resource "aws_instance" "private_ec2_1b" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = module.network.private_subnet2_id
  vpc_security_group_ids = [aws_security_group.private_ec2_sg.id]
  key_name              = var.key_name

  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y apache2
              systemctl start apache2
              systemctl enable apache2
              echo "<h1>Hello from Private EC2 in AZ 1b</h1>" > /var/www/html/index.html
              EOF

  tags = {
    Name = "private-ec2-instance-1b"
  }
}
