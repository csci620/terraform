
resource "azurerm_app_service_plan" "asp" {
  name                = "${var.qvc_mnemonic}-${var.qvc_environment_name}"
  location            = var.az_location
  resource_group_name = var.resource_group_name
  kind                = "Linux"
  reserved            = true

  sku {
    size = var.sku.size
    tier = var.sku.tier
  }
}
