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

variable "isPaused" {
  type        = bool
  default     = false
  description = "Sets the scheduler to active or paused"
}

variable "token_secret" {
  type        = string
  description = "The authorization bearer secret token"
}
