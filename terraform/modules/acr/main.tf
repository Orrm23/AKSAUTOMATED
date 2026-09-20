variable "environment"         { type = string }
variable "location"            { type = string; default = "eastus2" }
variable "resource_group_name" { type = string }

resource "azurerm_container_registry" "acr" {
  name                = "acr${var.environment}enterprise"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Premium"
  admin_enabled       = false
}

output "login_server" { value = azurerm_container_registry.acr.login_server }
