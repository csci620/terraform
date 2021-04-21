variable "name" {
  type = string 
}

variable "location" {
  type = string 
}

variable "resource_group_name" {
  type = string 
}

variable "offer_type" {
  type = string
  default = "Standard"
}

variable "throughput" {
  type = number
  default = 400
}
