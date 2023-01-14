terraform {
  backend "gcs" {
    bucket  = "atlas-source-prod-tf-state"
    prefix  = "setup"
  }
}
