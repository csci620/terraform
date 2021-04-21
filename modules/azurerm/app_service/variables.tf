variable "app_service_plan_id" {}
variable "qvc_environment_name" {}
variable "qvc_mnemonic" {}
variable "az_location" {}
variable "az_client_id" {}
variable "az_keyvault_uri" {}
variable "resource_group_name" {}
variable "storage_account" {
  default = []
}

variable "app_insights_instrumentation_key" {}

variable "tags" {}

variable "app_settings" {
  type    = map(string)
  default = {}
}

variable "linux_fx_version" {
  type    = string
  default = ""
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

variable "allowed_origins" {
  type    = list(string)
  default = []
}

variable "default_documents" {
  type = list(string)
  default = [
    "Default.htm",
    "Default.html",
    "Default.asp",
    "index.htm",
    "index.html",
    "iisstart.htm",
    "default.aspx",
    "index.php",
    "hostingstart.html",
    "home.aspx",
  ]
}