variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "application_insights_name" {
  type = string
}

variable "application_insights_kind" {
  type    = string
  default = "web"
}

variable "application_insights_retention_in_days" {
  type    = string
  default = "90"
}

variable "log_analytics_workspace_name" {
  type    = string
  default = "qvc-pf-log-ussc"
}

variable "log_analytics_resource_group_name" {
  type    = string
  default = "pf-log"
}

variable "tags" {
  type = map(string)
}
