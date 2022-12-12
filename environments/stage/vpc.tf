/******************************************
	VPC configuration
 *****************************************/
module "vpc" {
  source  = "../../modules/network-fabric/vpc"

  project_id   = var.project_id
  network_name = "stage-vpc"

  shared_vpc_host = true
}
