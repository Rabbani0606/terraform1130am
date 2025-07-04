resource "aws_vpc" "name" {
    cidr_block = "10.0.0.0/16"

    
  
}
 resource "aws_internet_gateway" "name" {
    vpc_id = aws_vpc.name.id

   
 }
  
 resource "aws_subnet" "dev" {
    cidr_block = "10.0.0.0/24"
    vpc_id = aws_vpc.name.id
   availability_zone = "us-east-1a"
 }
 resource "aws_route_table" "name" {
    vpc_id = aws_vpc.name.id
    route  {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.name.id

    }
   
 }
 resource "aws_route_table_association" "name" {
   subnet_id = aws_subnet.dev.id
   route_table_id = aws_route_table.name.id
 }
 resource "aws_instance" "name" {   
    ami = "ami-05ffe3c48a9991133"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.dev.id
    associate_public_ip_address = true
    vpc_security_group_ids = [aws_security_group.allow_tls.id]
   
 }
 # Create SG
resource "aws_security_group" "allow_tls" {
  name   = "allow_tls"
  vpc_id = aws_vpc.name.id

  tags = {
    Name = "dev_sg"
  }

  ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = "0"
    to_port   ="0"
    protocol  = "-1"
    cidr_blocks  = ["0.0.0.0/0"]
  }

}