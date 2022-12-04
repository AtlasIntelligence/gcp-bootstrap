variable "project_name" {
  description = "Project Name"
  type = string
}

variable "org_id" {
  description = "Project Name"
  type = string
}

variable "project_id" {
  description = "Unique project ID"
  type = string
}

variable "billing_account" {
  description = "Billing account assign to project"
  type = string
}

variable "gcp_service_list" {
  description ="The list of apis necessary for the project"
  type = list(string)
  default = [
    "cloudresourcemanager.googleapis.com",
    "serviceusage.googleapis.com",
    "servicenetworking.googleapis.com",
    "cloudkms.googleapis.com",
    "logging.googleapis.com",
    "bigquery.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "cloudbilling.googleapis.com",
    "iam.googleapis.com",
    "admin.googleapis.com",
    "appengine.googleapis.com",
    "storage-api.googleapis.com",
    "monitoring.googleapis.com",
    "pubsub.googleapis.com",
    "securitycenter.googleapis.com",
    "accesscontextmanager.googleapis.com",
    "billingbudgets.googleapis.com",
    "essentialcontacts.googleapis.com",
    "compute.googleapis.com",
    "vpcaccess.googleapis.com",
    "dns.googleapis.com"
  ]
}
