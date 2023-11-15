terraform {
  cloud {
    organization = "vkopel"

    workspaces {
      name = "terra-house-1"
    }
  }

  required_providers {
    random = {
      source = "hashicorp/random"
      version = "3.5.1"
    }
    aws = {
      source = "hashicorp/aws"
      version = "5.25.0"
    }
  }
}

provider "random" {
  # Configuration options
}

resource "random_string" "bucket_name" {
  upper = false
  lower = true
  length  = 32
  special = false
}


resource "aws_s3_bucket" "example" {
  bucket = random_string.bucket_name.result
}

output "random_bucket_name" {
    value = random_string.bucket_name.result
}