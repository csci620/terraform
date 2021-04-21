data "azurerm_subscription" "current" {
}

resource "azurerm_data_factory" "data_factory" {
  name                      = var.data_factory_name
  resource_group_name       = var.resource_group_name
  location                  = var.az_location
  identity {
    type = "SystemAssigned"
  }
  vsts_configuration {
    account_name            = var.data_factory_devops_account
    branch_name             = var.data_factory_devops_branch
    project_name            = var.data_factory_devops_project
    repository_name         = var.data_factory_devops_repository
    root_folder             = var.data_factory_devops_root_folder
    tenant_id               = data.azurerm_subscription.tenant_id
  }

  tags = {
    Environment = var.tags
  }
}
