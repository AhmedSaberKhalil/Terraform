output vpc_id {
    value= aws_vpc.main.id
}

output public_subnet1_id {
    value= aws_subnet.main-1a.id
}   

output public_subnet2_id {
    value= aws_subnet.main_1b.id
}

output private_subnet1_id {
    value= aws_subnet.private_1a.id
}

output private_subnet2_id {
    value= aws_subnet.private_1b.id
}
output nat_gateway_id {
    value= aws_nat_gateway.main.id
}
output internet_gateway_id {
    value= aws_internet_gateway.main.id
}