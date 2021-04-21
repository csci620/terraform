provider "azurerm" {
  features {}
  alias           = "p000"
  subscription_id = "295836ce-0b0c-4a20-a9c4-6c4785abbef4" // TODO - vars
}

data "azurerm_dns_zone" "dns_zone" {
  provider            = azurerm.p000
  name                = "q360.ai"    // TODO - vars
  resource_group_name = "pf-net-dns" // TODO - vars
}

locals {
  container = var.container
  cname     = format("%s%s", var.qvc_base_url, var.qvc_environment_name == "prod" ? "" : "-${var.qvc_environment_name}")
  hostname  = format("%s%s.%s", var.qvc_base_url, var.qvc_environment_name == "prod" ? "" : "-${var.qvc_environment_name}", var.qvc_default_domain)
}

module "asp" {
  source = "../../azurerm/app_service_plan"

  qvc_environment_name = var.qvc_environment_name
  qvc_mnemonic         = var.qvc_mnemonic
  az_location          = var.az_location
  resource_group_name  = var.resource_group_name
}

module "application_insights" {
  source = "../../azurerm/application_insights"

  location                  = var.az_location
  resource_group_name       = var.resource_group_name
  application_insights_name = "${var.qvc_mnemonic}-${var.qvc_environment_name}"

  tags = var.tags
}

module "app_service" {
  source                           = "../../azurerm/app_service"

  app_service_plan_id              = module.asp.id
  app_insights_instrumentation_key = module.application_insights.instrumentationKey
  app_settings                     = var.app_settings
  az_location                      = var.az_location
  az_client_id                     = var.az_client_id
  az_keyvault_uri                  = var.az_keyvault_uri
  linux_fx_version                 = "DOCKER|qfp100cntrdev01ussc.azurecr.io/${local.container}:${var.qvc_environment_name}"
  qvc_environment_name             = var.qvc_environment_name
  qvc_mnemonic                     = var.qvc_mnemonic
  resource_group_name              = var.resource_group_name
  storage_account                  = var.storage_account
  tags                             = var.tags
  depends_on = [
    module.application_insights
  ]
}

resource "azurerm_dns_cname_record" "cname" {
  provider            = azurerm.p000
  name                = local.cname
  zone_name           = data.azurerm_dns_zone.dns_zone.name
  resource_group_name = data.azurerm_dns_zone.dns_zone.resource_group_name
  ttl                 = 300
  record              = module.app_service.default_site_hostname
  tags                = var.tags
  depends_on = [
    module.app_service
  ]
}

resource "azurerm_dns_txt_record" "txt" {
  provider            = azurerm.p000
  name                = "asuid.${local.hostname}"
  zone_name           = data.azurerm_dns_zone.dns_zone.name
  resource_group_name = data.azurerm_dns_zone.dns_zone.resource_group_name
  ttl                 = 300
  record {
    value = module.app_service.custom_domain_verification_id
  }
  tags = var.tags
  depends_on = [
    module.app_service
  ]
}

resource "azurerm_app_service_custom_hostname_binding" "host" {
  hostname            = local.hostname
  app_service_name    = "${var.qvc_mnemonic}-${var.qvc_environment_name}"
  resource_group_name = "${var.qvc_mnemonic}-${var.qvc_environment_name}"
  depends_on = [
    azurerm_dns_txt_record.txt
  ]
}

resource "azurerm_app_service_managed_certificate" "managed_cert" {
  custom_hostname_binding_id = azurerm_app_service_custom_hostname_binding.host.id
}

resource "azurerm_app_service_certificate_binding" "cert_binding" {
  hostname_binding_id = azurerm_app_service_custom_hostname_binding.host.id
  certificate_id      = azurerm_app_service_managed_certificate.managed_cert.id
  ssl_state           = "SniEnabled"
}
