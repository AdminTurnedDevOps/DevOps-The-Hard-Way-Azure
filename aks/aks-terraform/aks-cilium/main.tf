terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.sub
}

resource "azurerm_kubernetes_cluster" "k8squickstart" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "${var.name}-dns01"

  network_profile {
  network_plugin       = "azure"
  network_plugin_mode  = "overlay"
  network_policy       = "cilium"
  network_data_plane   = "cilium"
}

  default_node_pool {
    name       = "default"
    node_count = var.node_count
    vm_size    = "Standard_A2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
  }
}
