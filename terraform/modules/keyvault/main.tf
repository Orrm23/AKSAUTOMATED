variable "environment"         { type = string }
variable "location"            { type = string; default = "eastus2" }
variable "resource_group_name" { type = string }

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "kv" {
  name                       = "kv-${var.environment}-security"
  location                   = var.location
  resource_group_name        = var.resource_group_name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"
  purge_protection_enabled   = true
}

resource "azurerm_key_vault_key" "cosign_key" {
  name         = "cosign-signing-key"
  key_vault_id = azurerm_key_vault.kv.id
  key_type     = "RSA"
  key_size     = 2048
  key_opts     = ["sign", "verify"]
}

output "key_vault_uri" { value = azurerm_key_vault.kv.vault_uri }
