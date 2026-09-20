provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg_prod" {
  name     = "rg-prod-aks"
  location = "eastus2"
}

module "networking" {
  source              = "../../modules/vnet"
  environment         = "prod"
  resource_group_name = azurerm_resource_group.rg_prod.name
  vnet_cidr           = "10.200.0.0/16"
  aks_subnet_cidr     = "10.200.0.0/20"
  agic_subnet_cidr    = "10.200.16.0/24"
}

module "keyvault" {
  source              = "../../modules/keyvault"
  environment         = "prod"
  resource_group_name = azurerm_resource_group.rg_prod.name
}

module "aks_prod" {
  source              = "../../modules/aks"
  environment         = "prod"
  resource_group_name = azurerm_resource_group.rg_prod.name
  subnet_id           = module.networking.aks_subnet_id
}
