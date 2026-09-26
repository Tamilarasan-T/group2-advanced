module "network" {
  source = "../../modules/network"

  name               = "payments-api"
  environment        = var.environment
  vpc_cidr           = "10.30.0.0/16"
  availability_zones = ["us-east-1a", "us-east-1b"]

  public_subnet_cidrs = [
    "10.30.1.0/24",
    "10.30.2.0/24"
  ]

  private_subnet_cidrs = [
    "10.30.11.0/24",
    "10.30.12.0/24"
  ]
}

module "iam" {
  source = "../../modules/iam"

  name            = "payments-api"
  environment     = var.environment
  trusted_service = "ecs-tasks.amazonaws.com"
}

module "container" {
  source = "../../modules/container"

  name        = "payments-api"
  environment = var.environment
}

module "observability" {
  source = "../../modules/observability"

  name           = "payments-api"
  environment    = var.environment
  log_group_name = "/acme/payments-api"
}
