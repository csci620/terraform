data "azurerm_container_registry" "container_registry" {
  provider            = azurerm.S000
  name                = "quantumeps"
  resource_group_name = "default-S000"
}
