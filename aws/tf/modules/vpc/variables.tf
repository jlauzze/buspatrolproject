variable "profile" {
  description = "Profile of account that this VPC is deployed in"
  type = string
}

variable "env" {
  description = "environment type to be used on all the resources as a tag"
  type        = string
}

variable "department" {
  description = "department"
  type        = string
}

variable "family" {
  description = "ivd or ruo"
  type        = string
}

variable "cidr" {
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overriden"
  default     = "10.10.0.0/16"
  type        = string
}

variable "public_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
}

variable "private_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
}

variable "azs" {
  description = "A list of availability zones in the region"
  type        = list(string)
  default     = ["us-west-2a", "us-west-2b", "us-west-2c"]
}

variable "enable_nat_gateway" {
  description = "enable_nat_gateway true or false"
  type        = bool
  default     = false
}

variable "enable_vpc_endpoints" {
  description = "Set to true to enable vpc endpoints."
  type        = bool
  default     = false
}
