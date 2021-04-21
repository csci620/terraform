variable "qvc_environment_name" {}
variable "qvc_mnemonic" {}
variable "qvc_base_url" {}
variable "qvc_default_domain" {}
variable "az_location" {}
variable "az_client_id" {}
variable "resource_group_name" {}
variable "az_keyvault_uri" {}
variable "container" {}

variable "storage_account" {
  default = []
}


variable "sku" {
  type = object({
    tier = string
    size = string
  })
  default = {
    tier = "Standard"
    size = "S1"
  }
}

variable "tags" {
  type = map(string)
}

variable "app_settings" {
  type    = map(string)
  default = {}
}

