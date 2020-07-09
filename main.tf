provider "azurerm" {
    version = "~>1.32.0"
    use_msi = true
    subscription_id = "2aba0967-5f05-4c8f-8a41-d9d7988af4ea"
    client_id       = "b29d733a-01ce-464e-9c56-62ef443c633a"
    client_secret   = "bc776c79-15fa-4a3b-8b80-d1b68eb1bf2b"
    tenant_id       = "e81ea96d-ffd8-4749-9585-84a65d47b0f7"

}

resource "azurerm_resource_group" "resowor" {
    name     = "Resourcegroupwork"
    location = "westus"
}

resource "azurerm_storage_account" "example" {
  name                     = "stoaccwork"
  resource_group_name      = azurerm_resource_group.resowor.name
  location                 = azurerm_resource_group.resowor.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_app_service_plan" "appserplanwor" {
  name                = "Appservplanwork"
  location            = azurerm_resource_group.resowor.location
  resource_group_name = azurerm_resource_group.resowor.name
  kind                = "FunctionApp"

  sku {
    tier = "Dynamic"
    size = "Y1"
  }
}

resource "azurerm_function_app" "funcappwor" {
  name                      = "azurefunctionwork"
  location                  = azurerm_resource_group.resowor.location
  resource_group_name       = azurerm_resource_group.resowor.name
  app_service_plan_id       = azurerm_app_service_plan.appserplanwor.id
  storage_connection_string = azurerm_storage_account.example.primary_connection_string
}



