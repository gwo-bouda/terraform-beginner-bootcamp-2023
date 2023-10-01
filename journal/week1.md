Week 1

## Root module Structure

Our root module structure is as follows:
```
 PROJECT_ROOT
   ├
   ├── main.tf - all else
   ├── variables.tf - store structure of input variables
   ├── providers.tf - define required providers and conf
   ├── outputs.tfv- store outpus
   ├── terraform.tfvars - the data of variables we load into terraform
   ├── READ.md - required for root modules
```
[Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)

## Fixing Tags

[How to Delete Local and Remote Tags on Git](https://devconnected.com/how-to-delete-local-and-remote-tags-on-git/)

Locally delete a tag
```sh
git tag -d <tag_name>
```

Remotely delete tag

```sh
git push --delete origin tagname
```

Checkout the commit that you want to retag. Grab the sha from your Github history.

```sh
git checkout <SHA>
git tag M.M.P
git push --tags
git checkout main
```

## Terraform input vars
### Terrfaform Cloud Variables

In Terraform we can set :
- Env variables (normally set in bash terminal)
- Terraform variables (normally set in tfvars files)

We can set terraform cloud variables to be sensitive so they aren't visible in the UI.

### Loading terraform variables

[TF input vars](https://developer.hashicorp.com/terraform/language/values/variables)

### var flag
We can use the `-var` flag to set an input variable or overide a variable in the tfvars file.
`terraform plan -var user_uuid="uuid"`

### var-file flag

### terraform.tfvars
This is the default file to load TF variable in bulk.

### auto.tfvars

### order of TF variables


## Configuration drift

### Fix missing resources
``` terraform import aws_s3_bucket.website_bucket```
[aws s3 bucket import](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket#import)

[TF import](https://developer.hashicorp.com/terraform/cli/import)

### Fix manual configuration
If cloud resources are deleted or modified manually
Run tf plan again to put back infra back to previous state

### FIx using tf refresh
[TF refresh cmd](https://developer.hashicorp.com/terraform/cli/commands/refresh)

## Terraform Module Source
In main.tf source the modules ->
```
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.user_uuid
  bucket_name = var.bucket_name
}
```
[TF Module Source](https://developer.hashicorp.com/terraform/language/modules/sources)


## Working with Files in Terraform


### Fileexists function

This is a built in terraform function to check the existance of a file.

```tf
condition = fileexists(var.error_html_filepath)
```

https://developer.hashicorp.com/terraform/language/functions/fileexists

### Filemd5

https://developer.hashicorp.com/terraform/language/functions/filemd5

### Path Variable

In terraform there is a special variable called `path` that allows us to reference local paths:
- path.module = get the path for the current module
- path.root = get the path for the root module
[Special Path Variable](https://developer.hashicorp.com/terraform/language/expressions/references#filesystem-and-workspace-info)


resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "index.html"
  source = "${path.root}/public/index.html"
}

## Terraform Locals

Locals allows us to define local variables.
It can be very useful when we need transform data into another format and have referenced a varaible.

```tf
locals {
  s3_origin_id = "MyS3Origin"
}
```
[Local Values](https://developer.hashicorp.com/terraform/language/values/locals)


## Terraform Data Sources

 used to source data from cloud resources.

This is useful when we want to reference cloud resources without importing them.

```tf
data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}
```
[Data Sources](https://developer.hashicorp.com/terraform/language/data-sources)

## Working with JSON

We use the jsonencode to create/convert the policy to json within tf files.

```tf
> jsonencode({"hello"="world"})
{"hello":"world"}
```

[jsonencode](https://developer.hashicorp.com/terraform/language/functions/jsonencode)

### changing the lifecycle rule of resources
[Lifecycle rule](https://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle)

### Terraform Data

 You can use terraform_data's behavior of planning an action each time input changes to indirectly use a plain value to trigger replacement with replace_triggered_by.

https://developer.hashicorp.com/terraform/language/resources/terraform-data

## Provisioners

Provisioners allow you to execute commands on compute instances eg. a AWS CLI command.

They are not recommended for use by Hashicorp because Configuration Management tools such as Ansible are a better fit, but the functionality exists.

[Provisioners](https://developer.hashicorp.com/terraform/language/resources/provisioners/syntax)

### Local-exec

This will execute command on the machine running the terraform commands eg. plan apply

```tf
resource "aws_instance" "web" {
  # ...

  provisioner "local-exec" {
    command = "echo The server's IP address is ${self.private_ip}"
  }
}
```

https://developer.hashicorp.com/terraform/language/resources/provisioners/local-exec

### Remote-exec

This will execute commands on a remote machine.  You will need to provide credentials such as ssh to get into the machine.

```tf
resource "aws_instance" "web" {
  # ...

  # Establishes connection to be used by all
  # generic remote provisioners (i.e. file/remote-exec)
  connection {
    type     = "ssh"
    user     = "root"
    password = var.root_password
    host     = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "puppet apply",
      "consul join ${aws_instance.web.private_ip}",
    ]
  }
}
```
https://developer.hashicorp.com/terraform/language/resources/provisioners/remote-exec

## For Each Expressions

For each allows us to enumerate data types

```sh
[for s in var.list : upper(s)]
```

This is mostly useful when you are creating multiples of a cloud resource and you want to reduce the amount of repetitive terraform code.

[For Each Expressions](https://developer.hashicorp.com/terraform/language/expressions/for)