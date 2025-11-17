terraform {
    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = ">= 4.00"
        }
    }
    random = {
            source = "hashicorp/random"
            version = ">= 3.0.0"
        }
}

provider "azurerm" {
    features {}
    subscription_id = "78033352-805c-4acd-af80-f8f95083268d"
}

resource "azurerm_resource_group" "az400-dev" {
    name = "az400-dev"
    location = "westeurope"
}

resource "azurerm_service_plan" "az400-dev" {
    name                = "terraformPlan"
    location            = azurerm_resource_group.az400-dev.location
    resource_group_name = azurerm_resource_group.az400-dev.name
    os_type = "Linux"
    sku_name = "S1"
}

resource "random_integer" "random_id" {
    min = 1000
    max = 9999
}

resource "azurerm_linux_web_app" "az400-dev" {
    name                = "terraform-web-${random_integer.random_id.result}"
    location            = azurerm_resource_group.az400-dev.location
    resource_group_name = azurerm_resource_group.az400-dev.name
    service_plan_id     = azurerm_service_plan.az400-dev.id

    site_config {}
}