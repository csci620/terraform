# Create Databricks workspace

resource "azurerm_databricks_workspace" "databricks_workspace" {
  name                      = var.databricks_workspace_name
  resource_group_name       = var.resource_group_name
  location                  = var.az_location
  sku                       = var.databricks_workspace_sku

  tags = {
    Environment = var.tags
  }
}

# Create Databricks token

resource "databricks_token" "token" {
  provider = databricks.databricks_provider
  comment  = "Created by Terraform"
  lifetime_seconds = var.databricks_token_lifetime
  depends_on = [azurerm_databricks_workspace.databricks_workspace]
}

# Store Databricks token in Key Vault

resource "azurerm_key_vault_secret" "token_secret" {
  name         = var.databricks_workspace_name
  value        = databricks_token.token.token_value
  key_vault_id = azurerm_key_vault.keyvault.id
  depends_on = [databricks_token.token]
}