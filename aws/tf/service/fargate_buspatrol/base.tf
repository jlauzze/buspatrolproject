provider "aws" {
  profile = var.profile
  region  = "us-west-2"
}

variable "aws_account_id" {
  default = "756717229274"
  type    = string
}

variable "profile" {
  default = "default"
  type    = string
}

variable "region" {
  default = "us-west-2"
  type    = string
}

#terraform { //not working anymore. probably a glitch in provider and my macbook running M1
#  backend "s3" {
#    encrypt        = true
#    bucket         = "default-terraform-common-terraform-state"
#    key            = "tf/tf-demo/terraform.tfstate"
#    dynamodb_table = "terraform-statelock"
#    profile        = "default"
#    region         = "us-west-2"
#  }
#}