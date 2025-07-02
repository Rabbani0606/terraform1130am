terraform {
  backend "s3" {
    bucket = "backendstattee"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
