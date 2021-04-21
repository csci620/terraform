data "azurerm_client_config" "client_config" {}

resource "azurerm_network_security_group" "nsg" {
  location            = var.location
  resource_group_name = var.resource_group_name
  name                = var.nsg_name
  security_rule       = var.nsg_rules

  tags = var.tags
}

resource "azurerm_subnet_network_security_group_association" "association" {
  subnet_id                 = var.subnet_id
  network_security_group_id = azurerm_network_security_group.nsg.id
}
