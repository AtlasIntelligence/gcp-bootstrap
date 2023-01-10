# Terraform Google Cloud DNS Module

## Compatibility

 This module is meant for use with Terraform 0.12. If you haven't [upgraded](https://www.terraform.io/upgrade-guides/0-12.html) and need a Terraform 0.12.x-compatible version of this module, the last released version intended for Terraform 0.11.x is [1.0.0](https://registry.terraform.io/modules/terraform-google-modules/cloud-dns/google/1.0.0).

## Usage

Basic usage of this module for a private zone is as follows:

```hcl
module "apps" {
  source = "../../modules/cloud-run"
  container-name = "apps"
  container-image = lower(var.data-container-image)
  env = var.data-env
  ports  = var.ports
  cpus = 1
  memory = 512
}
```
