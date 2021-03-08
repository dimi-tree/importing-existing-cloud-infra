output "aws_users" {
  value = data.terraform_remote_state.aws.outputs.aws_users
}

output "local_users" {
  value = module.users
}
