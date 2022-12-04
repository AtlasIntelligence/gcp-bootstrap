# Upload function (object) in Cloud Storage
# https://www.terraform.io/docs/providers/google/r/storage_bucket_object.html
resource "google_storage_bucket_object" "archive_function" {
  name   = var.bucket_archive_name
  bucket = var.bucket_name
  source = var.local_path
}

# Create new CloudFunction
# https://www.terraform.io/docs/providers/google/r/cloudfunctions_function.html
resource "google_cloudfunctions_function" "function" {
  name                  = var.function_name
  description           = var.function_description
  runtime               = var.runtime

  available_memory_mb   = var.function_memory
  source_archive_bucket = var.bucket_name
  source_archive_object = google_storage_bucket_object.archive_function.name
  trigger_http          = true
  https_trigger_security_level = var.security_level

  timeout               = var.function_timeout
  entry_point           = var.function_entry_point
  labels = var.labels
  environment_variables = var.environment
}

# IAM entry for all users to invoke the function
resource "google_cloudfunctions_function_iam_member" "invoker" {
  project        = google_cloudfunctions_function.function.project
  region         = google_cloudfunctions_function.function.region
  cloud_function = google_cloudfunctions_function.function.name

  role   = "roles/cloudfunctions.invoker"
  member = "allUsers"
}


