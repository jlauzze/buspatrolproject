/*
 * ##  VPC and associated resources
 *
 * This module creates a private VPC and related Resources
  https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/
 *
 */

module "network" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.70.0"

  name            = "${var.profile}-${var.env}-vpc"
  cidr            = var.cidr
  azs             = var.azs
  private_subnets = var.private_subnets

  enable_dns_hostnames = true
  enable_vpn_gateway   = true
  enable_nat_gateway   = var.enable_nat_gateway
  single_nat_gateway   = true
  public_subnets       = var.public_subnets

  // VPC Endpoints
  enable_s3_endpoint             = var.enable_vpc_endpoints
  enable_secretsmanager_endpoint = var.enable_vpc_endpoints
  enable_ses_endpoint            = var.enable_vpc_endpoints
  enable_sns_endpoint            = var.enable_vpc_endpoints
  enable_ssm_endpoint            = var.enable_vpc_endpoints
  enable_ssmmessages_endpoint    = var.enable_vpc_endpoints
  enable_states_endpoint         = var.enable_vpc_endpoints
  enable_ec2_endpoint            = var.enable_vpc_endpoints
  enable_ec2messages_endpoint    = var.enable_vpc_endpoints
  enable_ecr_api_endpoint        = var.enable_vpc_endpoints
  enable_ecr_dkr_endpoint        = var.enable_vpc_endpoints
  enable_ecs_agent_endpoint      = var.enable_vpc_endpoints
  enable_ecs_endpoint            = var.enable_vpc_endpoints
  enable_ecs_telemetry_endpoint  = var.enable_vpc_endpoints
  enable_logs_endpoint           = var.enable_vpc_endpoints
  enable_monitoring_endpoint     = var.enable_vpc_endpoints

  secretsmanager_endpoint_private_dns_enabled = true
  sns_endpoint_private_dns_enabled            = true
  ssm_endpoint_private_dns_enabled            = true
  ssmmessages_endpoint_private_dns_enabled    = true
  states_endpoint_private_dns_enabled         = true
  ec2_endpoint_private_dns_enabled            = true
  ec2messages_endpoint_private_dns_enabled    = true
  ecr_api_endpoint_private_dns_enabled        = true
  ecr_dkr_endpoint_private_dns_enabled        = true
  ecs_agent_endpoint_private_dns_enabled      = true
  ecs_endpoint_private_dns_enabled            = true
  ecs_telemetry_endpoint_private_dns_enabled  = true
  logs_endpoint_private_dns_enabled           = true
  monitoring_endpoint_private_dns_enabled     = true

  secretsmanager_endpoint_security_group_ids = var.enable_vpc_endpoints ? [aws_security_group.vpc_endpoints[0].id] : null
  ses_endpoint_security_group_ids            = var.enable_vpc_endpoints ? [aws_security_group.vpc_endpoints[0].id] : null
  sns_endpoint_security_group_ids            = var.enable_vpc_endpoints ? [aws_security_group.vpc_endpoints[0].id] : null
  ssm_endpoint_security_group_ids            = var.enable_vpc_endpoints ? [aws_security_group.vpc_endpoints[0].id] : null
  ssmmessages_endpoint_security_group_ids    = var.enable_vpc_endpoints ? [aws_security_group.vpc_endpoints[0].id] : null
  states_endpoint_security_group_ids         = var.enable_vpc_endpoints ? [aws_security_group.vpc_endpoints[0].id] : null
  ec2_endpoint_security_group_ids            = var.enable_vpc_endpoints ? [aws_security_group.vpc_endpoints[0].id] : null
  ec2messages_endpoint_security_group_ids    = var.enable_vpc_endpoints ? [aws_security_group.vpc_endpoints[0].id] : null
  ecr_api_endpoint_security_group_ids        = var.enable_vpc_endpoints ? [aws_security_group.vpc_endpoints[0].id] : null
  ecr_dkr_endpoint_security_group_ids        = var.enable_vpc_endpoints ? [aws_security_group.vpc_endpoints[0].id] : null
  ecs_agent_endpoint_security_group_ids      = var.enable_vpc_endpoints ? [aws_security_group.vpc_endpoints[0].id] : null
  ecs_endpoint_security_group_ids            = var.enable_vpc_endpoints ? [aws_security_group.vpc_endpoints[0].id] : null
  ecs_telemetry_endpoint_security_group_ids  = var.enable_vpc_endpoints ? [aws_security_group.vpc_endpoints[0].id] : null
  logs_endpoint_security_group_ids           = var.enable_vpc_endpoints ? [aws_security_group.vpc_endpoints[0].id] : null
  monitoring_endpoint_security_group_ids     = var.enable_vpc_endpoints ? [aws_security_group.vpc_endpoints[0].id] : null

  tags = {
    Profle = var.profile
    Env                = var.env
    Family             = var.family
    Department         = var.department
    Terraformed        = "True"
  }

  vpc_tags = {
    Name = "${var.profile}-${var.env}-vpc"
  }

  vpn_gateway_tags = {
    Name = "${var.profile}-${var.env}-vpc-vpn-gateway"
  }
}
