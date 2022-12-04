############################
###        FUNCTION      ###
############################

variable "function_name" {
  type        = string
  description = "A user-defined name of the function. Function names must be unique globally"
}

variable "runtime" {
  type    = string
  default = "nodejs16"
}

variable "function_description" {
  type        = string
  default     = ""
  description = "Description of the function"
}

variable "function_memory" {
  type        = string
  default     = 128
  description = "Memory (in MB), available to the function. Allowed values are: 128MB, 256MB, 512MB, 1024MB, and 2048MB"
}

variable "function_timeout" {
  type        = string
  default     = 30
  description = "Timeout (in seconds) for the function. Default value is 60 seconds. Cannot be more than 540 seconds"
}

variable "function_entry_point" {
  type        = string
  description = "Name of a JavaScript function that will be executed when the Google Cloud Function is triggered"
}

variable "security_level" {
  type        = string
  description = "The security level for the function. The following options are available: SECURE_ALWAYS, SECURE_OPTIONAL"
  default     = "SECURE_ALWAYS"
}

variable "environment" {
  type        = map(string)
  description = ""
  default     = {
    MY_ENV_VAR = "my-env-var-value"
  }
}

variable "labels" {
  type        = map(string)
  description = ""
  default     = {
    my-label = "my-label-value"
  }
}
############################
###        BUCKET        ###
############################

variable "bucket_name" {
  type        = string
  description = "The name of the containing bucket"
}

variable "bucket_archive_name" {
  type        = string
  default     = "index.zip"
  description = "The name of the object"
}

############################
###        LOCAL         ###
############################

variable "local_path" {
  type        = string
  description = "A path to the data you want to upload"
}
