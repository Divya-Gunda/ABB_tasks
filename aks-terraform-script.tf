provider "azurerm" {
  features {}
}

# Define the resource group
resource "azurerm_resource_group" "aks_rg" {
  name     = "aks-rg"
  location = "East US"
}

# Define the virtual network
resource "azurerm_virtual_network" "aks_vnet" {
  name                = "aks-vnet"
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name
  address_space       = ["10.0.0.0/8"]
}

# Define the subnet for AKS
resource "azurerm_subnet" "aks_subnet" {
  name                 = "aks-subnet"
  resource_group_name  = azurerm_resource_group.aks_rg.name
  virtual_network_name = azurerm_virtual_network.aks_vnet.name
  address_prefixes     = ["10.240.0.0/16"]
}

# Define Azure Monitor Workspace
resource "azurerm_log_analytics_workspace" "aks_workspace" {
  name                = "aks-log-analytics-workspace"
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name
  sku                 = "PerGB2018"
}

# Define the AKS cluster
resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = "aks-cluster"
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name
  dns_prefix          = "aks-cluster"

  default_node_pool {
    name       = "default"
    node_count = 3
    vm_size    = "Standard_DS2_v2"
    vnet_subnet_id = azurerm_subnet.aks_subnet.id
  }

  identity {
    type = "SystemAssigned"
  }

  enable_rbac = true

  # Enable Azure Monitor integration for the AKS cluster
  addon_profile {
    oms_agent {
      enabled                    = true
      log_analytics_workspace_id = azurerm_log_analytics_workspace.aks_workspace.id
    }
  }
}

# Output the KubeConfig
output "kube_config" {
  value = azurerm_kubernetes_cluster.aks_cluster.kube_config[0].raw_kube_config
}

