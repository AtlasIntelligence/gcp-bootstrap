variable "name" {
  type = string
}

variable "description" {
  type = string
}

variable "schedule" {
  type        = string
  description = "The schedule in cron notation"
}

variable "url" {
  description = "The url that must be called"
}
