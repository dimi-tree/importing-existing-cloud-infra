// syntax is compatible with specific versions of Terraform, starting at 0.13
terraform {
  required_version = ">= 0.13.0, < 1.0.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }

  backend "s3" {
    bucket = "cloudesk-ufa8qb421yzeu2f-state-bucket"
    key    = "aws/terraform.tfstate"
    region = "eu-west-1"
    encrypt = true
    role_arn = "arn:aws:iam::378188211969:role/cloudesk-ufa8qb421yzeu2f-tf-assume-role"
    dynamodb_table = "cloudesk-ufa8qb421yzeu2f-state-lock"

  }

}

// instantiate AWS provider with a region
provider "aws" {
  region = "eu-west-1"
}

// create 100 users
module "users" {
  source = "../modules/cloudesk-user/"
  for_each = toset([
    for i in range(10) : format("aws-%02d", i)
  ])

  name = each.key

  providers = {
    aws = aws
  }
}
