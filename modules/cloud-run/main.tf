locals {
  env = toset([
    for e in var.env : {
      key   = e.key
      value = e.value
    }
  ])
}

resource "google_cloud_run_service" "this" {
  name     = lower(var.container-name)
  location = var.region

  connection {}

  template {
    spec {
      containers {
        image = lower(var.container-image)
        ports {
          container_port = var.ports.port
        }
        dynamic "env" {
          for_each = [for e in local.env : e if e.value != null]

          content {
            name  = env.value.key
            value = env.value.value
          }
        }
        resources {
          limits = {
            cpu    = "${var.cpus * 1000}m"
            memory = "${var.memory}Mi"
          }
        }
      }
    }

    metadata {
      annotations = {
        "run.googleapis.com/ingress"       = "all"
        "autoscaling.knative.dev/metric"   = "cpu"
        "autoscaling.knative.dev/maxScale" = var.max_instances
        "autoscaling.knative.dev/minScale" = var.is_prod ? "1" : "0"
        "run.googleapis.com/client-name"   = "terraform"
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }

  autogenerate_revision_name = true
}

data "google_iam_policy" "noauth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

resource "google_cloud_run_service_iam_policy" "noauth" {
  location = google_cloud_run_service.this.location
  project  = google_cloud_run_service.this.project
  service  = google_cloud_run_service.this.name

  policy_data = data.google_iam_policy.noauth.policy_data
}


