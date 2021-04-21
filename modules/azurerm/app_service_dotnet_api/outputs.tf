output "identity_tenant_id" {
  value = azurerm_app_service.api.identity[0].tenant_id
}

output "identity_principal_id" {
  value = azurerm_app_service.api.identity[0].principal_id
}
