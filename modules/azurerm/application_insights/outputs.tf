output "id" {
  value = azurerm_template_deployment.application_insights.outputs["id"]
}

output "instrumentationKey" {
  value = azurerm_template_deployment.application_insights.outputs["instrumentationKey"]
}

output "connectionString" {
  value = azurerm_template_deployment.application_insights.outputs["connectionString"]
}
