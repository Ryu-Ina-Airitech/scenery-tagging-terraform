#-------------------------
# Terraform configuration
#-------------------------
terraform {
  required_version = ">0.13"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>3.0"
    }
  }
}

#-------------------------
# Proviider
#-------------------------
provider "aws" {
  profile = "ina-terraform"
  # region  = "ap-northeast-1"
  region = "us-east-1"
}

#-------------------------
# Variables
#-------------------------
variable "project" {
  type = string
}

variable "environment" {
  type = string
}
