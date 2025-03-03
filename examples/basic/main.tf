module "networking" {
  # Source the networking module from SailerAI's GitHub repository
  source = "github.com/SailerAI/terraform-aws-networking"

  # Project identification and environment settings
  project_name = var.project_name
  environment  = var.environment
  region       = var.region

  vpc_cidr         = "10.100.0.0/16"
  private_subnets  = ["10.100.0.0/20", "10.100.16.0/20", "10.100.32.0/20"]
  public_subnets   = ["10.100.48.0/24", "10.100.49.0/24", "10.100.50.0/24"]
  database_subnets = ["10.100.51.0/24", "10.100.52.0/24", "10.100.53.0/24"]
  azs              = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

