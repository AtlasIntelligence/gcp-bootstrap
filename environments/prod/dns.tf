module "public-dns" {
  source      = "../../modules/network-fabric/dns"
  project_id  = module.project.project_id
  type        = "public"
  name        = "public-dns"
  domain      = "source.atin.io."
}
