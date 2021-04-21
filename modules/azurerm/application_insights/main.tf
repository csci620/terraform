data "azurerm_client_config" "client_config" {}

locals {
  parameters_body = {
    location = {
      value = var.location
    },
    applicationInsightsName = {
      value = var.application_insights_name
    },
    applicationInsightsKind = {
      value = var.application_insights_kind
    },
    applicationInsightsRetentionInDays = {
      value = var.application_insights_retention_in_days
    },
    workspaceName = {
      value = var.log_analytics_workspace_name
    },
    workspaceResourceGroupName = {
      value = var.log_analytics_resource_group_name
    },
    tags = {
      value = var.tags
    }
  }
}

resource "azurerm_template_deployment" "application_insights" {
  name                = "application-insights_terraform_module"
  resource_group_name = var.resource_group_name
  deployment_mode     = "Incremental"

  parameters_body = jsonencode(local.parameters_body)
  template_body   = file("${path.module}/application-insights-template.json")
}
