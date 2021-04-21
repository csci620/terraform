data "azurerm_key_vault" "keyvault" {
  name                = var.keyvault_name
  resource_group_name = var.resource_group_name
}

data "azurerm_databricks_workspace" "databricks_workspace" {
  name                = var.databricks_workspace_name
  resource_group_name = var.resource_group_name
}

# Create Databricks secret scope

resource "databricks_secret_scope" "secret_scope" {
  name = var.keyvault_name
  initial_manage_principal = "users"

  keyvault_metadata {
    resource_id = data.azurerm_key_vault.keyvault.id
    dns_name = data.azurerm_key_vault.keyvault.vault_uri
  }
}
