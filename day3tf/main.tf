resource "aws_instance" "name" {
    ami = var.ami
    instance_type = var.type

  
}
resource "aws_s3_bucket" "name" {
    bucket = "zakeera"
  
}