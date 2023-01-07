# Return Service dns url
output "url" {
  value = google_dns_record_set.record_set.name
}
