variable "location" {
    type    = string
}

variable "rg_name" {
    type    = string
}

variable "workspace_name" {
    type    = string
}

variable "workspace_sku" {
    type    = string
}

variable "log_analytics_solution_name" {
    type    = string
    default = null
}

variable "log_analytics_solution_publisher" {
    type    = string
    default = null
}

variable "log_analytics_solution_product" {
    type    = string
    default = null
}

variable "log_analytics_solution_lock_level" {
    type    = string
    default = null
}

variable "tags" {
    type    = map
    default = {}
}
