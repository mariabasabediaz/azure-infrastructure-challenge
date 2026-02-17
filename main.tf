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

# 4. Perfil de CDN (El "cerebro" del CDN)
resource "azurerm_cdn_profile" "cdn" {
  name                = "cdn-profile-${var.environment}"
  location            = "Global"
  resource_group_name = azurerm_resource_group.main.name
  sku                 = "Standard_Microsoft"
}

# 5. Punto de enlace del CDN (El que hace que la web sea rápida)
resource "azurerm_cdn_endpoint" "endpoint" {
  name                = "fsl-challenge-${var.environment}-endpoint"
  profile_name        = azurerm_cdn_profile.cdn.name
  location            = "Global"
  resource_group_name = azurerm_resource_group.main.name
  origin_host_header  = azurerm_storage_account.storage.primary_web_host
  is_http_allowed     = true
  is_https_allowed    = true

  origin {
    name      = "storageorigin"
    host_name  = azurerm_storage_account.storage.primary_web_host
  }
}

# 6. Envío de Logs (Rerouting logs to Workspace)
resource "azurerm_monitor_diagnostic_setting" "storage_logs" {
  name                       = "logs-to-workspace"
  target_resource_id         = "${azurerm_storage_account.storage.id}/blobServices/default"
  log_analytics_workspace_id = azurerm_log_analytics_workspace.logs.id

  enabled_log {
    category = "StorageWrite"
  }

  metric {
    category = "AllMetrics"
    enabled  = true
  }
}
