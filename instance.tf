provider "aws" {
	region = "ap-south-1"
}


terraform {
  backend "s3" {
    bucket = "save-terraform-state-files"
    key    = "key/terraform.tfstate"
    region = "ap-south-1"
  }
}