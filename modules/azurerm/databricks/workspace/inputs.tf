variable "databricks_workspace_name" {
    type = string
}

variable "resource_group_name" {
    type = string
}

variable "az_location" {
    type = string
}

variable "databricks_workspace_sku" {
    type = string
    default = "standard"
}

variable "databricks_token_lifetime" {
    type = string
    default = 8640000
}

variable "tags" {
    type = string
}

variable "keyvault_name" {
    type = string
}
