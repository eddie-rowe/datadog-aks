variable "client_id" {
  type    = string
  default = null
}

variable "client_secret" {
  type    = string
  default = null
}

variable "create_resource_group" {
  type     = bool
  default  = true
  nullable = false
}

variable "key_vault_firewall_bypass_ip_cidr" {
  type    = string
  default = null
}

variable "location" {
  # uscentral does not contain datadog services?
  # Monitor Name: "example-monitor"): performing MonitorsCreate: unexpected status 400 (400 Bad Request) 
  # with error: LocationNotAvailableForResourceType: The provided location 'centralus' is not available
  # for resource type 'Microsoft.Datadog/monitors'. List of available regions for the resource type is 'westus2'.
  default = "uswest2"
}

variable "managed_identity_principal_id" {
  type    = string
  default = null
}

variable "resource_group_name" {
  type    = string
  default = null
}

variable "datadog_api_key" {
  type    = string
  default = "null"
}

variable "datadog_app_key" {
  type    = string
  default = "null"
}