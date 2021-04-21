data "azurerm_client_config" "client_config" {}

locals {
    default_access_policies = []
}

resource "azurerm_key_vault" "key_vault" {
  name                            = var.name
  location                        = var.location
  resource_group_name             = var.resource_group_name
  enabled_for_disk_encryption     = true
  tenant_id                       = data.azurerm_client_config.client_config.tenant_id
  purge_protection_enabled        = false
  sku_name                        = var.sku_name
  enabled_for_deployment          = true
  enabled_for_template_deployment = true
  soft_delete_retention_days      = 90
  tags = var.tags
}
