output "public_instance_1_ip" {
  description = "Public IP of the first EC2 instance"
  value       = aws_instance.ec2_1a.public_ip
}

output "public_instance_2_ip" {
  description = "Public IP of the second EC2 instance"
  value       = aws_instance.ec2_1b.public_ip
}

output "load_balancer_dns" {
  description = "DNS name of the Application Load Balancer"
  value       = aws_lb.main.dns_name
}
