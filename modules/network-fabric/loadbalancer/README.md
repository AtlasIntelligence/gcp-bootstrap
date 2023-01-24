# Terraform Google Cloud DNS Module

## Compatibility

This module is meant for use with Terraform 0.12. If you haven't [upgraded](https://www.terraform.io/upgrade-guides/0-12.html) and need a Terraform 0.12.x-compatible version of this module, the last released version intended for Terraform 0.11.x is [1.0.0](https://registry.terraform.io/modules/terraform-google-modules/cloud-dns/google/1.0.0).

## Usage

Basic usage of this module for a private zone is as follows:

Template to create a load balancer that routes traffic to one Cloud Run Service:
```hcl
module "lb-http" {
  source            = "../../modules/"

  project           = "my-project-id"
  name              = "my-lb"

  ssl                             = true
  managed_ssl_certificate_domains = ["your-domain.com"]
  https_redirect                  = true
  backends = {
    default = {
      description                     = null
      enable_cdn                      = false
      custom_request_headers          = null
      custom_response_headers         = null
      security_policy                 = null


      log_config = {
        enable = true
        sample_rate = 1.0
      }

      groups = [
        {
          # Your serverless service should have a NEG created that's referenced here.
          group = google_compute_region_network_endpoint_group.default.id
        }
      ]

      iap_config = {
        enable               = false
        oauth2_client_id     = null
        oauth2_client_secret = null
      }
    }
  }
}
```

Here is an example that can be used to create a load balancer that routes traffic to different Cloud Run services based on the requested path:
```terraform
locals {
  path_matcher = {
    allpaths = {
      fqdn = "your-domain.com"
    }
  }
  backends = {
    foo = {
      regex = "/foo/*"
    }
    bar = {
      regex = "/bar/*"
    }
  }
}
module "lb-http" {
  source            = "../../modules/"

  project           = "my-project-id"
  name              = "my-lb"

  ssl                             = true
  managed_ssl_certificate_domains = ["your-domain.com"]
  https_redirect                  = true

  path_matcher = local.path_matcher
  path_rule = local.path_rule
  
  backends = {
    foo = {
      description                     = null
      enable_cdn                      = false
      custom_request_headers          = null
      custom_response_headers         = null
      security_policy                 = null
      log_config = {
        enable = true
        sample_rate = 1.0
      }
      groups = [
        {
          group = google_compute_region_network_endpoint_group.default.id
        }
      ]
      iap_config = {
        enable               = false
        oauth2_client_id     = null
        oauth2_client_secret = null
      }
    }
    bar = {
      description                     = null
      enable_cdn                      = false
      custom_request_headers          = null
      custom_response_headers         = null
      security_policy                 = null
      log_config = {
        enable = true
        sample_rate = 1.0
      }
      groups = [
        {
          group = google_compute_region_network_endpoint_group.default.id
        }
      ]
      iap_config = {
        enable               = false
        oauth2_client_id     = null
        oauth2_client_secret = null
      }
    }
  }
}
```
