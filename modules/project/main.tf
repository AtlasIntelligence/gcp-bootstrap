resource "google_project" "this" {
  name       = var.project_name
  org_id     = var.org_id
  project_id = var.project_id

  billing_account = var.billing_account
}

resource "google_project_service" "gcp_services" {
  for_each = toset(var.gcp_service_list)
  project = google_project.this.project_id
  service = each.key
}
