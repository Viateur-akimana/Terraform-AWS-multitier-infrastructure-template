# Networking Module
module "networking" {
  source = "./modules/networking"
}

# Security Module 
module "security" {
  source = "./modules/security"
  vpc_id = module.networking.vpc_id

  depends_on = [module.networking]
}

# ALB Module
module "alb" {
  source            = "./modules/alb"
  vpc_id            = module.networking.vpc_id
  public_subnet_ids = module.networking.public_subnet_ids
  security_group_id = module.security.web_sg_id

  depends_on = [module.networking, module.security]
}

# Compute Module
module "compute" {
  source             = "./modules/compute"
  private_subnet_ids = module.networking.private_app_subnet_ids
  security_group_id  = module.security.app_sg_id
  target_group_arn   = module.alb.target_group_arn

  depends_on = [module.security, module.networking, module.alb]
}

# DB Module
module "database" {
  source                = "./modules/database"
  vpc_id                = module.networking.vpc_id
  private_db_subnet_ids = module.networking.private_db_subnet_ids
  security_group_id     = module.security.db_sg_id

  depends_on = [module.networking, module.security]
}
