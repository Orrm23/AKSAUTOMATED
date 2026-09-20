variable "environment"         { type = string }
variable "location"            { type = string; default = "eastus2" }
variable "resource_group_name" { type = string }
variable "vnet_cidr"           { type = string }
variable "aks_subnet_cidr"     { type = string }
variable "agic_subnet_cidr"    { type = string }

resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = [var.vnet_cidr]
}

resource "azurerm_subnet" "aks_subnet" {
  name                 = "snet-aks-${var.environment}"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.aks_subnet_cidr]
}

resource "azurerm_subnet" "agic_subnet" {
  name                 = "snet-agic-${var.environment}"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.agic_subnet_cidr]
}

output "aks_subnet_id"  { value = azurerm_subnet.aks_subnet.id }
output "agic_subnet_id" { value = azurerm_subnet.agic_subnet.id }
