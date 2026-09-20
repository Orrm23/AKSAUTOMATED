variable "environment"         { type = string }
variable "location"            { type = string; default = "eastus2" }
variable "resource_group_name" { type = string }
variable "subnet_id"           { type = string }

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${var.environment}-aks"
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "${var.environment}-aks"

  default_node_pool {
    name       = "system"
    node_count = var.environment == "prod" ? 3 : 1
    vm_size    = "Standard_D4s_v5"
    vnet_subnet_id = var.subnet_id
  }

  identity {
    type = "SystemAssigned"
  }

  ingress_application_gateway {
    gateway_name = "agic-${var.environment}"
    subnet_id    = var.subnet_id
  }
}

output "aks_cluster_name" { value = azurerm_kubernetes_cluster.aks.name }
