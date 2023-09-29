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