locals {

  granular_sa = {
    "bootstrap" = "Foundation Bootstrap SA. Managed by Terraform.",
    "env"       = "Foundation Environment SA. Managed by Terraform.",
    "net"       = "Foundation Network SA. Managed by Terraform.",
    "proj"      = "Foundation Projects SA. Managed by Terraform.",
  }

  common_roles = [
    "roles/browser", // Required for gcloud beta terraform vet to be able to read the ancestry of folders
  ]

  granular_sa_org_level_roles = {

    "bootstrap" = distinct(concat([
      "roles/resourcemanager.organizationAdmin",
      "roles/accesscontextmanager.policyAdmin",
      "roles/serviceusage.serviceUsageConsumer",
    ], local.common_roles)),

    "env" = distinct(concat([
      "roles/resourcemanager.tagUser",
    ], local.common_roles)),

    "net" = distinct(concat([
      "roles/accesscontextmanager.policyAdmin",
      "roles/compute.xpnAdmin",
    ], local.common_roles)),

    "proj" = distinct(concat([
      "roles/accesscontextmanager.policyAdmin",
      "roles/resourcemanager.organizationAdmin",
      "roles/serviceusage.serviceUsageConsumer",
    ], local.common_roles)),
  }

  granular_sa_parent_level_roles = {

    "bootstrap" = [
      "roles/resourcemanager.folderAdmin",
    ],

    "env" = [
      "roles/resourcemanager.folderAdmin"
    ],

    "net" = [
      "roles/resourcemanager.folderViewer",
      "roles/compute.networkAdmin",
      "roles/compute.securityAdmin",
      "roles/compute.orgSecurityPolicyAdmin",
      "roles/compute.orgSecurityResourceAdmin",
      "roles/dns.admin",
    ],

    "proj" = [
      "roles/resourcemanager.folderViewer",
      "roles/resourcemanager.folderIamAdmin",
      "roles/artifactregistry.admin",
      "roles/compute.networkAdmin",
      "roles/compute.xpnAdmin",
    ],
  }

  // Roles required to manage resources in the Seed project
  granular_sa_project = {

    "bootstrap" = [
      "roles/storage.admin",
      "roles/iam.serviceAccountAdmin",
      "roles/resourcemanager.projectDeleter",
    ],

    "env" = [
      "roles/storage.objectAdmin"
    ],

    "net" = [
      "roles/storage.objectAdmin",
    ],

    "proj" = [
      "roles/storage.objectAdmin",
    ],
  }

  // Roles required to manage resources in the CI/CD project
  granular_sa_cicd_project = {
    "bootstrap" = [
      "roles/storage.admin",
      "roles/compute.networkAdmin",
      "roles/cloudbuild.builds.editor",
      "roles/cloudbuild.workerPoolOwner",
      "roles/artifactregistry.admin",
      "roles/source.admin",
      "roles/iam.serviceAccountAdmin",
      "roles/workflows.admin",
      "roles/cloudscheduler.admin",
      "roles/resourcemanager.projectDeleter",
    ],
  }
}

resource "google_service_account" "atlas-source-sa" {
  for_each = local.granular_sa

  project      = var.project_id
  account_id   = "sa-atlas-${each.key}"
  display_name = each.value
}

resource "google_project_iam_member" "project" {
  project = var.project_id
  role    = "roles/editor"
  member  = "user:yannick.siewe@adorsys.com"
}

resource "google_project_iam_audit_config" "project" {
  project = var.project_id
  service = "allServices"
  audit_log_config {
    log_type = "ADMIN_READ"
  }
  audit_log_config {
    log_type = "DATA_READ"
    exempted_members = [
      "user:yannick.siewe@adorsys.com",
    ]
  }
}
