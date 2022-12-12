variable "ports" {
  description = "container ports configuration"
  type        = map(any)
  default     = {
    port      = "8080"
    protocol  = "TCP"
  }
}

variable "container-image" {
  description = "Container image"
  default     = "us-docker.pkg.dev/cloudrun/container/hello"
}

variable "apps-env" {
  description = "Environment variables to inject into container instances."
  default = [
    {
      key   = "ENV_KEY",
      value = "env_value"
    },
    {
      key   = "ANOTHER_ENV_KEY",
      value = "another_env_value"
    }
  ]
}
