data "azurerm_client_config" "current" {}

locals {
  default_app_settings = {
    "APPINSIGHTS_INSTRUMENTATIONKEY"             = var.app_insights_instrumentation_key
    "APPINSIGHTS_JAVASCRIPT_ENABLED"             = "true"
    "APPLICATIONINSIGHTS_CONNECTION_STRING"      = "InstrumentationKey=${var.app_insights_instrumentation_key}"
    "ApplicationInsightsAgent_EXTENSION_VERSION" = "~2"
    "DOCKER_ENABLE_CI"                           = "true"
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE"        = "false"
  }
}

locals {
  default_name     = "${var.qvc_mnemonic}-${var.qvc_environment_name}"
  linux_fx_version = var.linux_fx_version
  app_settings     = merge(local.default_app_settings, var.app_settings)
}

resource "azurerm_app_service" "app_service" {
  resource_group_name     = var.resource_group_name
  app_service_plan_id     = var.app_service_plan_id
  app_settings            = local.app_settings
  client_affinity_enabled = true
  /* client_cert_enabled           = false */
  /* connection_string             = [] */
  /* custom_domain_verification_id = "63290189F12D55FC5FE5409C889438A4318CA5E6A88614594063CB9910CD32DC" */
  /* default_site_hostname         = "qed-prod-qvc.azurewebsites.net" */
  enabled    = true
  https_only = true
  location   = var.az_location
  name       = local.default_name

  identity  {
    type         = "SystemAssigned"
  }

  dynamic "storage_account" {
    for_each = var.storage_account
    content {
      type = "AzureBlob" 
      name = storage_account.value["name"]
      account_name = storage_account.value["account_name"]
      share_name = storage_account.value["share_name"]
      access_key = storage_account.value["access_key"]
      mount_path = storage_account.value["mount_path"]
    }
  }

  site_config {
    always_on        = true
    app_command_line = ""
    cors {
      allowed_origins     = var.allowed_origins
      support_credentials = false
    }

    default_documents        = var.default_documents
    dotnet_framework_version = "v4.0"
    ftps_state               = "AllAllowed"
    health_check_path        = ""
    http2_enabled            = true
    ip_restriction           = []
    linux_fx_version         = local.linux_fx_version
    managed_pipeline_mode    = "Integrated"
    min_tls_version          = "1.2"
  }

  tags = var.tags
}