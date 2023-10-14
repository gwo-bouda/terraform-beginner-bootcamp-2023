terraform {
  required_providers {
    terratowns = {
     source = "local.providers/local/terratowns"
     version = "1.0.0"

    }
  }
  #backend "remote" {
  #  hostname = "app.terraform.io"
  #  organization = "TerraformBootcamp2023_FD"

  #  workspaces {
  #    name = "terra-house-1"
  #  }
  #}
  cloud {
    organization = "TerraformBootcamp2023_FD"
    workspaces {
      name = "terra-house-1"
    }
  }
 }

provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid=var.teacherseat_user_uuid
  token=var.terratowns_access_token

}


module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.teacherseat_user_uuid
  bucket_name = var.bucket_name
  index_html_filepath = var.index_html_filepath
  error_html_filepath = var.error_html_filepath
  assets_path = var.assets_path
  content_version = var.content_version
}

 resource "terratowns_home" "home" {
  name = "Void Bastards"
  description = <<DESCRIPTION
This is a game to play.
DESCRIPTION
  domain_name = module.terrahouse_aws.cloudfront_url
  town = "gamers-grotto"
  content_version = 1
}

