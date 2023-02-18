locals {
  service_dns = "${lower(var.service_dns_prefix)}.${data.google_dns_managed_zone.dns_zone.dns_name}"
  source_dns  = data.google_dns_managed_zone.dns_zone.dns_name

  service_dns_record = var.service_name == "source" && var.service_dns_prefix == "" ? local.source_dns : local.service_dns
}

data "google_dns_managed_zone" "dns_zone" {
  name = var.dns_zone_name
}

module "cloudrun" {
  source          = "../cloud-run"
  container-name  = lower(var.service_name)
  container-image = lower(var.container_image)
  env             = var.apps_env
  ports           = var.ports
  cpus            = var.container_cpu
  memory          = var.container_memory
  is_prod         = var.is_prod
  max_instances   = var.max_instances
}

resource "google_cloud_run_domain_mapping" "default" {
  # name     = local.service_dns_record
  name     = "data-augmention.source.dev.atin.io"
  location = module.cloudrun.location
  metadata {
    namespace = var.project_id
  }
  spec {
    route_name = module.cloudrun.name
  }
  depends_on = [
    module.cloudrun
  ]
}

resource "google_dns_record_set" "record_set" {
  name = "${var.service_dns_prefix}."
  type = "CNAME"
  ttl  = 300

  managed_zone = data.google_dns_managed_zone.dns_zone.name

  rrdatas = ["ghs.googlehosted.com."]
}
