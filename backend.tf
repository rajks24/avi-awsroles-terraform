terraform {
  backend "s3" {
    region         = "ap-southeast-2"
    bucket         = "terraform-state-bucket-prod"
    key            = "avi-prod-terraform.tfstate"
    dynamodb_table = "terraform-lock"
  }
}
