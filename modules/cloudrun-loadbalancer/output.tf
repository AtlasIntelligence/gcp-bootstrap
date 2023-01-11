# Return Service dns url
output "url" {
  value = google_dns_record_set.record_set.name
}

output "dns_zone" {
  value = data.google_dns_managed_zone.dns_zone.dns_name
}
