provider "aws" {
	region = "ap-south-1"
}


terraform {
  backend "s3" {
    bucket = "save-application-jars"
    key    = "key/terraform.tfstate"
    region = "ap-south-1"
  }
}