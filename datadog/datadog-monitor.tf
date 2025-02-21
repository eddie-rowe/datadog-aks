# Create a new Datadog - Microsoft Azure integration
# https://registry.terraform.io/providers/DataDog/datadog/latest/docs/resources/integration_azure

#resource "datadog_integration_azure" "sandbox" {
#  tenant_name              = "<azure_tenant_name>"
#  client_id                = "<azure_client_id>"
#  client_secret            = "<azure_client_secret_key>"
#  host_filters             = "examplefilter:true,example:true"
#  app_service_plan_filters = "examplefilter:true,example:another"
#  container_app_filters    = "examplefilter:true,example:one_more"
#  automute                 = true
#  cspm_enabled             = true
#  custom_metrics_enabled   = false
#}



# Azure native programmatic management:
# https://docs.datadoghq.com/integrations/guide/azure-native-programmatic-management/


# Azure Datadog Monitor resource
#resource "azurerm_resource_group" "example" {
#  name     = "<NAME>"
#  location = "<AZURE_REGION>"
#}

resource "azurerm_datadog_monitor" "example" {
  name                = "example-monitor"
  resource_group_name = azurerm_resource_group.main[0].name
  location            = azurerm_resource_group.main[0].location
  datadog_organization {
    api_key         = var.datadog_api_key
    application_key = var.datadog_app_key
  }
  user {
    # (required) The name which should be used for this user_info. Changing this forces a new resource to be created.
    name  = "ExampleUserName"
    # (required) Email of the user used by Datadog for contacting them if needed. Changing this forces a new Datadog Monitor to be created
    email = "example@gmail.com"
  }
  sku_name = "Linked"
  identity {
    type = "SystemAssigned"
  }
}

# Monitoring reader role
data "azurerm_subscription" "primary" {}

data "azurerm_role_definition" "monitoring_reader" {
  name = "Monitoring Reader"
}

resource "azurerm_role_assignment" "example" {
  scope              = data.azurerm_subscription.primary.id
  role_definition_id = data.azurerm_role_definition.monitoring_reader.role_definition_id
  principal_id       = azurerm_datadog_monitor.example.identity.0.principal_id
}