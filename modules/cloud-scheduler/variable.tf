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
  type        = string
  description = "The url that must be called"
}

variable "http_method" {
  type        = string
  default     = "POST"
  description = "The HTTP method that must be used e.g. GET, POST"
}

variable "headers" {
  type        = map(string)
  default     = { "User-Agent" : "Google-Cloud-Scheduler" }
  description = "Headers that must be used for e.g. Authentication"
}

variable "isPaused" {
  type        = bool
  default     = false
  description = "Sets the scheduler to active or paused"
}

variable "attempt_deadline" {
  type        = string
  default     = "320s"
  description = "The maximum amount of time to allow for a job execution"
}
