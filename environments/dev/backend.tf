terraform {
  backend "gcs" {
    bucket  = "atlas-source-develop-tf-state"
    prefix  = "setup"
  }
}
