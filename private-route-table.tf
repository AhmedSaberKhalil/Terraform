# Private route table
resource "aws_route_table" "private" {
  vpc_id = module.network.vpc_id

  route {
    cidr_block     = var.allow_all
    nat_gateway_id = module.network.nat_gateway_id
  }

  tags = {
    Name = "private-route-table"
  }
}

# Associate private subnet 1a with private route table
resource "aws_route_table_association" "private_1a" {
  subnet_id      = module.network.private_subnet1_id
  route_table_id = aws_route_table.private.id
}

# Associate private subnet 1b with private route table
resource "aws_route_table_association" "private_1b" {
  subnet_id      = module.network.private_subnet2_id
  route_table_id = aws_route_table.private.id
}
