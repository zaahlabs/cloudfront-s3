#terraform
terraform {
  required_version = ">= 0.13.5"
}

#aws virginia
provider "aws" {
  region = "us-east-1"
  alias  = "virginia"
}

#aws frankfurt
provider "aws" {
  region = "eu-central-1"
  alias  = "frankfurt"
}
