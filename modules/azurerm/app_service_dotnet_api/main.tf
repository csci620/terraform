# Create an App Service Plan with Linux
resource "azurerm_app_service_plan" "asp" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  # Define Linux as Host OS
  kind     = "Linux"
  reserved = true

  # Choose size
  sku {
    tier = var.tier
    size = var.size
  }
}

# Create an Azure Web App for Containers in that App Service Plan
resource "azurerm_app_service" "api" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  app_service_plan_id = azurerm_app_service_plan.asp.id
  https_only          = true

  app_settings = {
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = false
    DOTNET_ENVIRONMENT                  = var.dotnet_environment
    KeyVaultName                        = var.name

    # Settings for private Container Registires  
    DOCKER_ENABLE_CI                = true
    DOCKER_REGISTRY_SERVER_URL      = "https://${var.container_registry_login_server}"
    DOCKER_REGISTRY_SERVER_USERNAME = var.container_registry_admin_username
    DOCKER_REGISTRY_SERVER_PASSWORD = var.container_registry_admin_password
  }

  # Configure Docker Image to load on start
  site_config {
    linux_fx_version   = "DOCKER|${var.container_registry_login_server}/${var.container_registry_repository_name}:${var.container_registry_repository_tag}"
    ftps_state         = "Disabled"
    http2_enabled      = true
    websockets_enabled = true
    always_on          = "true"

    health_check_path = "/health"

    cors {
      allowed_origins = ["*"]
    }
  }

  identity {
    type = "SystemAssigned"
  }
}
