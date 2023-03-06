resource "aws_security_group" "vpc_endpoints" {
  count = var.enable_vpc_endpoints ? 1 : 0

  name        = "${var.profile}-${var.env}-vpc-endpoints-sg"
  description = "Allows services within VPC to communicate with external services within AWS."
  vpc_id      = module.network.vpc_id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.private_subnets
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.profile}-${var.env}-vpc-endpoints-sg"
    Profile = var.profile
    Env         = var.env
    Family      = var.family
    Department  = var.department
    Terraformed = "True"
  }
}
