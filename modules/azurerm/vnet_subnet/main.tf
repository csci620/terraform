data "azurerm_client_config" "client_config" {}

resource "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = var.address_prefixes
}

module "vnet_subnet_nsg" {
  source = "../vnet_subnet_nsg"

  for_each = { for n in var.nsg: n.nsg_name => n }

  location             = var.location
  resource_group_name  = var.resource_group_name
  nsg_name             = each.value.nsg_name
  nsg_rules            = each.value.rules
  subnet_id            = azurerm_subnet.subnet.id

  tags = var.tags
}
