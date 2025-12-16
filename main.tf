# Create Networking Module
module "networking" {
  source = "./modules/networking"
}

# Create Security Module
module "security" {
  source = "./modules/security"
  vpc_id = module.networking.vpc_id

  depends_on = [module.networking]
}

# Create Compute Module
module "compute" {
  source            = "./modules/compute"
  subnet_id         = module.networking.subnet_id
  security_group_id = module.security.security_group_id

  depends_on = [module.security, module.networking]
}

