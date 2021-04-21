variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "virtual_network_name" {
  type = string
}

variable "subnet_name" {
  type = string
}

variable "address_prefixes" {
  type = list(string)
}

variable "nsg" {
  type =  list(
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
}

variable "tags" {
  type    = map(string)
  default = {}
}
