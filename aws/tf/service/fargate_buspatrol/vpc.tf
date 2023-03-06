module "vpc" {
  source             = "../../modules/vpc"
  profile            = var.profile
  env                = "sandbox"
  department         = "devops"
  family             = "buspatrol"
  cidr               = "10.192.168.0/21"
  public_subnets     = ["10.192.168.0/24", "10.192.169.0/24", "10.192.170.0/24"]
  private_subnets    = ["10.192.173.0/24", "10.192.171.0/24", "10.192.172.0/24"]
  enable_nat_gateway = true
}