variable "name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "tier" {
  type    = string
  default = "Basic"
}

variable "size" {
  type    = string
  default = "B1"
}

variable "container_registry_login_server" {
  type = string
}

variable "container_registry_admin_username" {
  type = string
}

variable "container_registry_admin_password" {
  type = string
}

variable "container_registry_repository_name" {
  type = string
}

variable "container_registry_repository_tag" {
  type = string
}

variable "dotnet_environment" {
  type    = string
  default = "Development"
}
