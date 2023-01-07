data "google_dns_managed_zone" "dns_zone" {
  name =  var.dns_zone_name
}

module "cloudrun" {
  source          = "../cloud-run"
  container-name  = lower(var.service_name)
  container-image = lower(var.container_image)
  env             = var.apps_env
  ports           = var.ports
  cpus            = var.container_cpu
  memory          = var.container_memory
}

module "lb-http" {
  source  = "../network-fabric/loadbalancer"
  name    = "${lower(var.service_name)}-lb"
  project = lower(var.project_id)

  ssl                             = true
  managed_ssl_certificate_domains = ["${lower(var.service_dns_prefix)}.${data.google_dns_managed_zone.dns_zone.dns_name}"]
  https_redirect                  = true
  labels                          = var.labels

  backends = {
    default = {
      description = null
      groups = [
        {
          group = google_compute_region_network_endpoint_group.serverless_neg.id
        }
      ]
      # Changed this because it is required if compression is set
      enable_cdn              = false
      security_policy         = null
      custom_request_headers  = null
      custom_response_headers = null
      # Had to set this since otherwise terraform complains --  possible values "AUTOMATIC", "DISABLED"
      compression_mode        = "DISABLED"

      iap_config = {
        enable               = false
        oauth2_client_id     = ""
        oauth2_client_secret = ""
      }
      log_config = {
        enable      = true
        sample_rate = 0.1
      }
    }
  }

  depends_on = [module.cloudrun]
}

resource "google_compute_region_network_endpoint_group" "serverless_neg" {
  provider              = google-beta
  name                  = "${lower(var.service_name)}-serverless-neg"
  network_endpoint_type = "SERVERLESS"
  region                = var.region
  project               = var.project_id
  cloud_run {
    service = module.cloudrun.name
  }
}

resource "google_dns_record_set" "record_set" {
  name = "${lower(var.service_dns_prefix)}.${data.google_dns_managed_zone.dns_zone.dns_name}"
  type = "A"
  ttl  = 300

  managed_zone = data.google_dns_managed_zone.dns_zone.name

  rrdatas = [module.lb-http.external_ip]
}
