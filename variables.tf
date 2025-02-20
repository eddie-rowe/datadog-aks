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
  default = "centralus"
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
  default = null
}

variable "datadog_app_key" {
  type    = string
  default = null
}