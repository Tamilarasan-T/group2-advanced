module "network" {
  source = "../../modules/network"

  name               = "orders-api"
  environment        = var.environment
  vpc_cidr           = "10.20.0.0/16"
  availability_zones = ["us-east-1a", "us-east-1b"]

  public_subnet_cidrs = [
    "10.20.1.0/24",
    "10.20.2.0/24"
  ]

  private_subnet_cidrs = [
    "10.20.11.0/24",
    "10.20.12.0/24"
  ]
}

module "iam" {
  source = "../../modules/iam"

  name            = "orders-api"
  environment     = var.environment
  trusted_service = "ecs-tasks.amazonaws.com"
}

module "container" {
  source = "../../modules/container"

  name        = "orders-api"
  environment = var.environment
}

module "observability" {
  source = "../../modules/observability"

  name           = "orders-api"
  environment    = var.environment
  log_group_name = "/acme/orders-api"
}
