resource "google_pubsub_topic" "profile-data-enhancement" {
  project = module.project.project_id
  name = "profile-data-enhancement"

  labels = {
    service = "profile-db"
  }

  message_retention_duration = "86600s"
}
