provider "azurerm" {
    version = "~>1.32.0"
    use_msi = true
    subscription_id = "2aba0967-5f05-4c8f-8a41-d9d7988af4ea"
    client_id       = "bfd83f72-0497-4c68-970e-1f72357787dc"
    client_secret   = "R.L~0mb9KIF.QWFLjiWIQ-V7ZFhJDTXCKi"
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
  kind                = "linux"
  reserved            = true

  sku {
    tier = "Basic"
    size = "B1"
  }
}

resource "azurerm_app_service" "azureappserv"{
name                    ="appservicetestwor"
location                = azurerm_resource_group.resowor.location
resource_group_name     = azurerm_resource_group.resowor.name
app_service_plan_id     = azurerm_app_service_plan.appserplanwor.id
    
site_config{
    linux_fx_version    = "PHP|7.3"
    scm_type            ="LocalGit"
    }
}

resource "azurerm_function_app" "funcappwor" {
  name                      = "azurefunctionwork"
  location                  = azurerm_resource_group.resowor.location
  resource_group_name       = azurerm_resource_group.resowor.name
  app_service_plan_id       = azurerm_app_service_plan.appserplanwor.id
  storage_connection_string = azurerm_storage_account.example.primary_connection_string
    version = "~3"
    
    app_settings = {
        FUNCTIONS_WORKER_RUNTIME             = "node"
        WEBSITE_NODE_DEFAULT_VERSION         = "~12"
        WEBSITE_RUN_FROM_PACKAGE              = "1"
        }
}



