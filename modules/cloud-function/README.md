# Terraform Google Cloud DNS Module

## Compatibility

 This module is meant for use with Terraform 0.12. If you haven't [upgraded](https://www.terraform.io/upgrade-guides/0-12.html) and need a Terraform 0.12.x-compatible version of this module, the last released version intended for Terraform 0.11.x is [1.0.0](https://registry.terraform.io/modules/terraform-google-modules/cloud-dns/google/1.0.0).

## Usage

Basic usage of this module for a private zone is as follows:

```hcl
resource "google_storage_bucket" "bucket" {
  name = "test-bucket-cloudfunction"
}

module "cloudfunction" {
  source               = "../../modules/cloud-function"
  bucket_name          = "${google_storage_bucket.bucket.name}"
  bucket_archive_name  = "helloHttp.zip"
  local_path           = "${path.module}/code/helloHttp.zip"
  function_name        = "helloHttp"
  function_entry_point = "helloHttp"
  runtime              = "nodejs16"
  
  https_trigger_security_level = "SECURE_OPTIONAL"
  
  environment          = { MY_ENV_VAR = "my-env-var-value" }
  labels               = { my-label = "my-label-value" }
}
```
