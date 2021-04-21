variable "qvc_environment_name" {}
variable "qvc_mnemonic" {}
variable "az_location" {}
variable "resource_group_name" {}

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