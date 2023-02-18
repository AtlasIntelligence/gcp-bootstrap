# Return Service dns url
output "url" {
  value = google_dns_record_set.record_set.name
}

output "dns_zone" {
  value = data.google_dns_managed_zone.dns_zone.dns_name
}

output "cloud_run_service_account" {
  value = module.cloudrun.service_account
}
