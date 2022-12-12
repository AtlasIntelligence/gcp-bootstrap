/******************************************
	VPC configuration
 *****************************************/
module "vpc" {
  source  = "../../modules/network-fabric/vpc"

  project_id   = var.project_id
  network_name = "stage-vpc"

  shared_vpc_host = true
}

/******************************************
	Subnet configuration
 *****************************************/
module "subnets" {
  source           = "../../modules/network-fabric/subnets"
  project_id       = var.project_id
  network_name     = module.vpc.network_name

  subnets = var.subnets

  secondary_ranges = var.secondary_ranges
}

/******************************************
	Routes
 *****************************************/
module "routes" {
  source            = "../../modules/network-fabric/routes"
  project_id        = var.project_id
  network_name      = module.vpc.network_name

  routes            = var.routes

  module_depends_on = [module.subnets.subnets]
}
