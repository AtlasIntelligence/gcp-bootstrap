provider "google" {
  project = "atlas-source-stage"
  region = "europe-west3"
  zone = "europe-west3-a"
}

resource "google_compute_network" "public_vpc_network" {
  name                    = "public-vpc-network"
  auto_create_subnetworks = true
}
