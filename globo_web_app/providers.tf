terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

provider "random" {
  # Configuration options
}

provider "aws" {
  alias  = "west"
  region = "us-west-1"
}

provider "aws" {
  region = var.aws_region
}