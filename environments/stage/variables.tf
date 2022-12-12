variable "project_id" {
  type        = string
  description = "The ID of the project where this VPC will be created"
  default     = "atlassource"
}
variable "region" {
  type        = string
  description = "The region where to deploy resources"
  default     = "europe-west3"
}
