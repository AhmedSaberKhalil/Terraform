# Generate a new key pair
resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Create AWS key pair
resource "aws_key_pair" "generated_key" {
  key_name   = var.key_name
  public_key = tls_private_key.ssh_key.public_key_openssh
}

# Store private key in AWS Secrets Manager
resource "aws_secretsmanager_secret" "private_key" {
  name                    = var.public_key_secrets_manager_name
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "private_key_value" {
  secret_id     = aws_secretsmanager_secret.private_key.id
  secret_string = tls_private_key.ssh_key.private_key_pem
}
