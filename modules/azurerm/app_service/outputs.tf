output "id" {
  value = azurerm_app_service.app_service.id
}

output "custom_domain_verification_id" {
  value = azurerm_app_service.app_service.custom_domain_verification_id
}

output "default_site_hostname" {
  value = azurerm_app_service.app_service.default_site_hostname
}

output "principal_id" {
  value = azurerm_app_service.app_service.identity[0].principal_id
}