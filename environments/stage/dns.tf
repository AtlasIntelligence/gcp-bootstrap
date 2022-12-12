module "dns-private-zone" {
  source    = "../../modules/network-fabric/dns"
  project_id = var.project_id
  type       = "private"
  name       = "atlassource-com"
  domain     = "atlassource.com."

  private_visibility_config_networks = [
    "10.10.10.0/24", "10.10.20.0/24", "10.10.30.0/24"
  ]

  recordsets = [
    {
      name    = ""
      type    = "NS"
      ttl     = 300
      records = [
        "127.0.0.1",
      ]
    },
    {
      name    = "localhost"
      type    = "A"
      ttl     = 300
      records = [
        "127.0.0.1",
      ]
    },
  ]
}
