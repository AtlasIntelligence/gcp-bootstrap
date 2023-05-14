provider "google" {
  project = var.project_id
  region  = var.region
}

provider "google-beta" {
  project = var.project_id
  region  = var.region
}

module "project" {
  source = "../../modules/project"

  project_id = "prod-source-atlas"
  project_name = "prod-source-atlas"
  billing_account = "0165B4-557293-D88C4C"
  org_id = "253981344865"
}
