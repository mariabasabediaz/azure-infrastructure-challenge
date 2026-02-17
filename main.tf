# 1. Creamos el Grupo de Recursos con un nombre nuevo
resource "azurerm_resource_group" "main" {
  name     = "rg-final-challenge-2026"
  location = "East US"
}

# 2. Creamos la cuenta de almacenamiento (Storage Account)
resource "azurerm_storage_account" "storage" {
  name                     = "stfslchallenge${var.environment}2026" # Nombre único
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  static_website {
    index_document = "index.html"
  }
}

# 3. Creamos el Workspace de Log Analytics
resource "azurerm_log_analytics_workspace" "logs" {
  name                = "log-fsl-${var.environment}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}
