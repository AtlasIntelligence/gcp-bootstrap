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
variable "billing_acc" {
  default = ""
}

/******************************************
	Network configuration
 *****************************************/
variable "subnets" {
  type        = list(map(string))
  description = "The list of subnets being created"
  default     = [
    {
      subnet_name           = "subnet-01"
      subnet_ip             = "10.10.10.0/24"
      subnet_region         = "europe-west3"
    },
    {
      subnet_name           = "subnet-02"
      subnet_ip             = "10.10.20.0/24"
      subnet_region         = "europe-west3"
      subnet_private_access = "true"
      subnet_flow_logs      = "true"
      description           = "This subnet has a description"
    },
    {
      subnet_name                  = "subnet-03"
      subnet_ip                    = "10.10.30.0/24"
      subnet_region                = "europe-west3"
      subnet_flow_logs             = "true"
      subnet_flow_logs_interval    = "INTERVAL_10_MIN"
      subnet_flow_logs_sampling    = 0.7
      subnet_flow_logs_metadata    = "INCLUDE_ALL_METADATA"
      subnet_flow_logs_filter_expr = "true"
    }
  ]
}

variable "secondary_ranges" {
  type        = map(list(object({ range_name = string, ip_cidr_range = string })))
  description = "Secondary ranges that will be used in some of the subnets"
  default     = {
    subnet-01 = [
      {
        range_name    = "subnet-01-secondary-01"
        ip_cidr_range = "192.168.64.0/24"
      },
    ]

    subnet-02 = []
  }
}

variable "routes" {
  type        = list(map(string))
  description = "List of routes being created in this VPC"
  default     = [
    {
      name                   = "egress-internet"
      description            = "route through IGW to access internet"
      destination_range      = "0.0.0.0/0"
      tags                   = "egress-inet"
      next_hop_internet      = "true"
    }
  ]
}
