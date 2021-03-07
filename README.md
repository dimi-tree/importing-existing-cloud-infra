# LiveProject: Importing Existing Cloud Infrastructure into Terraform

### Requirements

* Terraform version >= 0.13.0
* Authenticated AWS CLI

### Overview

Running a `terraform init` and `terraform apply` on this code will create 100
IAM users in your authenticated AWS account.
Run a `terraform destroy` to remove these accounts again.

### Installing `terraform-provider-aws`

Terraform is capable of understanding that it needs to pull in the AWS provider when you use a resource that is registered as an AWS resource. So you don’t usually need to manually download and install officially supported providers.

However, we will be patching the AWS provider later, so it is a good idea to explicitly install a version of the provider to understand what is going on.

Find the source code for the AWS provider [here](https://github.com/hashicorp/terraform-provider-aws) and follow the [Development Environment Setup “Quick Start”](https://github.com/hashicorp/terraform-provider-aws/blob/main/docs/DEVELOPMENT.md).

Verify you have successfully built the provider:
```bash
$ cd terraform-providers
$ git clone git@github.com:hashicorp/terraform-provider-aws.git
[...]
$ cd terraform-provider-aws
$ make tools
[...]
$ make build
[...]
$ ls -al $GOPATH/bin/terraform-provider-aws
.rwxr-xr-x 212M chase 10 Sep 13:48 /home/chase/.local/lib/go/bin/terraform-provider-aws
```
*Note: your `ls -al` result might differ. This is fine so long as you see a roughly 200MB file.*


Then copy your locally built `terraform-provider-aws` binary to your terraform plugins folder:
```bash
mkdir -p ~/.terraform.d/plugins/registry.terraform.io/hashicorp/aws/3.31.0/darwin_amd64
cp $GOPATH/bin/terraform-provider-aws .terraform.d/plugins/registry.terraform.io/hashicorp/aws/3.31.0/darwin_amd64
```

When running `terraform init` in the Dataset project, you should see `unauthenticated`; this confirms we are using our local Terraform provider.
```bash
$ terraform init
Initializing modules...
- users in modules/cloudesk-user

Initializing the backend...

Initializing provider plugins...
- Finding hashicorp/aws versions matching "~> 3.0"...
- Installing hashicorp/aws v3.31.0...
- Installed hashicorp/aws v3.31.0 (unauthenticated)
```

Note: We just built our own `terraform-provider-aws` binary. You can do this same process for about every other Terraform provider in the open-source community. Usually, all that is needed is a `go install`, but most projects have custom build instructions you can follow.
