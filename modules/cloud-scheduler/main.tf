resource "google_cloud_scheduler_job" "job" {
  name             = var.name
  description      = var.description
  schedule         = var.schedule
  time_zone        = "Etc/UTC"
  attempt_deadline = "320s"
  paused           = var.isPaused

  retry_config {
    retry_count = 0
  }

  http_target {
    http_method = var.http_method
    uri         = var.url
    headers     = var.headers
  }
}
