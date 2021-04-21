output "login_server" {
  value = data.azurerm_container_registry.container_registry.login_server
}

output "admin_username" {
  value = data.azurerm_container_registry.container_registry.admin_username
}

output "admin_password" {
  value = data.azurerm_container_registry.container_registry.admin_password
}
