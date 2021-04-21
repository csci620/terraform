variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "virtual_network_name" {
  type = string
}

variable "address_space" {
  type = list(string)
}

variable "ddos_protection" {
  type = bool
}

variable "log_analytics" {
  type = list(
          object({
            la_subscription_id = string
            la_rg_name         = string
            la_name            = string
          })
  )
}

variable "subnet" {
  type = list(
          object({
            subnet_name      = string
            address_prefixes = list(string)
            nsg              = list(
                                object({
                                  nsg_name = string
                                  rules = list(
                                            object({
                                              access                                     = string
                                              description                                = string
                                              destination_address_prefix                 = string
                                              destination_address_prefixes               = list(string)
                                              destination_application_security_group_ids = list(string)
                                              destination_port_range                     = string
                                              destination_port_ranges                    = list(string)
                                              direction                                  = string
                                              name                                       = string
                                              priority                                   = number
                                              protocol                                   = string
                                              source_address_prefix                      = string
                                              source_address_prefixes                    = list(string)
                                              source_application_security_group_ids      = list(string)
                                              source_port_range                          = string
                                              source_port_ranges                         = list(string)
                                            })
                                  )
                                })
                              )
          })
    )
}

variable "tags" {
  type    = map(string)
  default = {}
}
