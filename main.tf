 terraform {
  required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
  #cloud {
    #organization = "vkopel"

    #workspaces {
      #name = "terra-house-1"
    #}
  #}
 }

 provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid = var.teacherseat_user_uuid
  token = var.terratowns_access_token
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
  name = "How to be a Cloud Engineer in 2024!"
  description = <<DESCRIPTION
My best recommendation for your journey to be a Cloud Engineer is to 
follow Andrew Brown's Tutorials. 
DESCRIPTION
  domain_name = module.terrahouse_aws.cloudfront_url
  #domain_name = "3fhjq3gz.cloudfront.net"
  town = "missingo"
  content_version = 1
}