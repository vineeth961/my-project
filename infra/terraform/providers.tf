terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"   # not 5, not 6
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

