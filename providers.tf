terraform {
  cloud {
    organization = "vkopel"

    workspaces {
      name = "terra-house-1"
    }
  }

  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.25.0"
    }
  }
}

provider "aws" {  
}
provider "random" {
  # Configuration options
}
