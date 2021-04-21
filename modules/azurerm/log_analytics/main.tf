resource "azurerm_log_analytics_workspace" "log_analytics_workspace" {
  # The WorkSpace name has to be unique across the whole of azure, not just the current subscription/tenant.
  name                = var.workspace_name
  location            = var.location
  resource_group_name = var.rg_name
  sku                 = var.workspace_sku
  tags                = var.tags
}

resource "azurerm_log_analytics_solution" "log_analytics_solution" {
  count                 = null == var.log_analytics_solution_name ? 0 : 1
  solution_name         = var.log_analytics_solution_name
  location              = var.location
  resource_group_name   = var.rg_name
  workspace_resource_id = azurerm_log_analytics_workspace.log_analytics_workspace.id
  workspace_name        = azurerm_log_analytics_workspace.log_analytics_workspace.name

  plan {
    publisher = var.log_analytics_solution_publisher
    product   = var.log_analytics_solution_product
  }
}

resource "azurerm_management_lock" "log_analytics_solution_lock" {
  count      = var.log_analytics_solution_lock_level == "CanNotDelete" || var.log_analytics_solution_lock_level == "ReadOnly" ? 1 : 0
  name       = "Lock from terraform configuration"
  scope      = azurerm_log_analytics_solution.log_analytics_solution[count.index].id
  lock_level = var.log_analytics_solution_lock_level
}
