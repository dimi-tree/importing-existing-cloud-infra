data "terraform_remote_state" "aws" {
  backend = "s3"

  config = {
    bucket = "cloudesk-ufa8qb421yzeu2f-state-bucket"
    key    = "aws/terraform.tfstate"
    region = "eu-west-1"
  }
}
