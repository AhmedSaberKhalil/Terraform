# Create public route table
resource "aws_route_table" "public" {
  vpc_id = module.network.vpc_id

  route {
    cidr_block = var.allow_all
    gateway_id = module.network.internet_gateway_id
  }

  tags = {
    Name = "public-route-table"
  }
}

# Associate public subnet 1a with public route table
resource "aws_route_table_association" "public_1a" {
  subnet_id      = module.network.public_subnet1_id
  route_table_id = aws_route_table.public.id
}

# Associate public subnet 1b with public route table
resource "aws_route_table_association" "public_1b" {
  subnet_id      = module.network.public_subnet2_id
  route_table_id = aws_route_table.public.id
}
