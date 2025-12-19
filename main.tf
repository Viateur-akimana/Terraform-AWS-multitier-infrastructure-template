# Networking Module
module "networking" {
  source             = "./modules/networking"
  vpc_cidr           = var.vpc_cidr
  availability_zones = var.availability_zones
  environment        = var.environment
  project_name       = var.project_name
  owner              = var.owner
}

# Security Module 
module "security" {
  source       = "./modules/security"
  vpc_id       = module.networking.vpc_id
  environment  = var.environment
  project_name = var.project_name
  owner        = var.owner

  depends_on = [module.networking]
}

# ALB Module
module "alb" {
  source            = "./modules/alb"
  vpc_id            = module.networking.vpc_id
  public_subnet_ids = module.networking.public_subnet_ids
  security_group_id = module.security.web_sg_id
  environment       = var.environment
  project_name      = var.project_name
  owner             = var.owner

  depends_on = [module.networking, module.security]
}

# Compute Module
module "compute" {
  source                    = "./modules/compute"
  private_subnet_ids        = module.networking.private_app_subnet_ids
  public_subnet_id          = module.networking.public_subnet_ids[0]
  security_group_id         = module.security.app_sg_id
  bastion_security_group_id = module.security.bastion_sg_id
  target_group_arn          = module.alb.target_group_arn
  instance_type             = var.instance_type
  key_name                  = var.key_name
  environment               = var.environment
  project_name              = var.project_name
  owner                     = var.owner

  depends_on = [module.security, module.networking, module.alb]
}

# DB Module
module "database" {
  source                = "./modules/database"
  vpc_id                = module.networking.vpc_id
  private_db_subnet_ids = module.networking.private_db_subnet_ids
  security_group_id     = module.security.db_sg_id
  db_name               = var.db_name
  db_username           = var.db_username
  db_password           = var.db_password
  environment           = var.environment
  project_name          = var.project_name
  owner                 = var.owner

  depends_on = [module.networking, module.security]
}
