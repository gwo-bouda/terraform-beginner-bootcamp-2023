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
