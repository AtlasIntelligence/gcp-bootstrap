module "backend" {
  source = "../../modules/cloud-run"
  container-name = "backend"
  container-image = lower(var.container-image)
  env = var.apps-env
  ports  = var.ports
  cpus = 1
  memory = 512
}
