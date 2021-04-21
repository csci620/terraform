data "azurerm_client_config" "client_config" {}

resource "azurerm_network_ddos_protection_plan" "ddos_protection_plan" {
  count = var.ddos_protection == true ? 1 : 0

  location            = var.location
  resource_group_name = var.resource_group_name
  name                = var.virtual_network_name
}

resource "azurerm_virtual_network" "virtual_network" {
  location            = var.location
  resource_group_name = var.resource_group_name
  name                = var.virtual_network_name
  address_space       = var.address_space

  dynamic "ddos_protection_plan" {
    for_each = var.ddos_protection ? [1] : []
    content {
      id     = azurerm_network_ddos_protection_plan.ddos_protection_plan[0].id
      enable = true
    }
  }

  tags = var.tags
}

# data "azurerm_subscription" "current" {
#   subscription_id = ""
# }

resource "azurerm_monitor_diagnostic_setting" "monitor_diagnostic_setting" {
  for_each = { for la in var.log_analytics: la.la_subscription_id => la }

  name                       = each.value.la_name
  target_resource_id         = azurerm_virtual_network.virtual_network.id
  log_analytics_workspace_id = format("/subscriptions/%s/resourcegroups/%s/providers/microsoft.operationalinsights/workspaces/%s", each.value.la_subscription_id, each.value.la_rg_name, each.value.la_name)

  metric {
    category = "AllMetrics"
  }
}

module "vnet_subnet" {
  source = "../vnet_subnet"

  for_each = { for s in var.subnet: s.subnet_name => s }

  location             = var.location
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.virtual_network.name
  subnet_name          = each.value.subnet_name
  address_prefixes     = each.value.address_prefixes
  nsg                  = each.value.nsg

  tags = var.tags
}
