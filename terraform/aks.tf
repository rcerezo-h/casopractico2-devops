resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks-cp2"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "aks-cp2"

  identity {
    type = "SystemAssigned"
  }

  default_node_pool {
    name       = "nodepool1"
    node_count = 1
    vm_size    = "Standard_B2as_v2"
  }

  network_profile {
    network_plugin = "azure"
  }

  tags = {
    environment = "casopractico2"
  }
}

resource "azurerm_role_assignment" "aks_acr_pull" {
  scope                = azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
}