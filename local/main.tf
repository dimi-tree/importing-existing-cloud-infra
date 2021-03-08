// syntax is compatible with specific versions of Terraform, starting at 0.13
terraform {
  required_version = ">= 0.13.0, < 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
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
    for i in range(10) : format("local-%02d", i)
  ])

  name = each.key

  providers = {
    aws = aws
  }
}

module "s3backend" {
  source = "../modules/s3backend/"
  namespace     = "cloudesk"
}
 
output "s3backend_config" {
  value = module.s3backend.config
}
