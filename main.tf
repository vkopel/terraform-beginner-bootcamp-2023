 terraform {
  required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
  cloud {
    organization = "vkopel"

    workspaces {
      name = "terra-house-1"
    }
  }
 }

 provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid = var.teacherseat_user_uuid
  token = var.terratowns_access_token
}

module "home_cloudengineer_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.cloudengineer.public_path
  content_version = var.cloudengineer.content_version
}

resource "terratowns_home" "home" {
  name = "How to be a Cloud Engineer in 2024!"
  description = <<DESCRIPTION
My best recommendation for your journey to be a Cloud Engineer is to 
follow Andrew Brown's Tutorials. 
DESCRIPTION
  domain_name = module.home_cloudengineer_hosting.domain_name
  #domain_name = "3fhjq3gz.cloudfront.net"
  town = "missingo"
  content_version = var.cloudengineer.content_version
}

module "home_exerciseday_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.exerciseday.public_path
  content_version = var.exerciseday.content_version
}

resource "terratowns_home" "home_exerciseday" {
  name = "Exercising at least thrice a week"
  description = <<DESCRIPTION
Exercising at least three times per week 
helps in boasting your immune 
system in order to always stay healthy.
DESCRIPTION
  domain_name = module.home_exerciseday_hosting.domain_name
  town = "the-nomad-pad"
  content_version = var.exerciseday.content_version
}