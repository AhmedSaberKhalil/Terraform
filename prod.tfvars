region = "us-east-1"
vpc_cidr = "12.0.0.0/16"
public_subnet1_cidr = "12.0.1.0/24"
public_subnet2_cidr = "12.0.2.0/24"
private_subnet1_cidr = "12.0.3.0/24"
private_subnet2_cidr = "12.0.4.0/24"
availability_zone1 = "us-east-1a"
availability_zone2 = "us-east-1b"
allow_all = "0.0.0.0/0"
instance_type = "t2.micro"
ami = "ami-0c7217cdde317cfec"
key_name = "terraform-key-pair"
public_key_secrets_manager_name = "ec2-ssh-private-key"