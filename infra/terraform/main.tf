terraform {
  required_version = ">= 1.9"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.27"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.7"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id                 = var.subscription_id
  use_oidc                        = true # Enable OIDC for Workload Identity Federation
  resource_provider_registrations = "none"
}

# Variables for parameterization
variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
  default     = "cd091145-5ea2-4703-ba5d-41063b1d4308"
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "az400-dev"
}

variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "westeurope"
}

variable "app_service_name" {
  description = "Name of the App Service"
  type        = string
  default     = "catalog-service-terraform"
}

# Resource group (use existing or create new)
data "azurerm_resource_group" "main" {
  name = var.resource_group_name
}

# Random suffix for unique naming
resource "random_integer" "suffix" {
  min = 1000
  max = 9999
}

# App Service Plan (Linux)
resource "azurerm_service_plan" "main" {
  name                = "terraform-plan-${random_integer.suffix.result}"
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name
  os_type             = "Linux"
  sku_name            = "S1"

  tags = {
    Environment = "Development"
    ManagedBy   = "Terraform"
    Purpose     = "AZ-400 Training"
  }
}

# Linux Web App
resource "azurerm_linux_web_app" "main" {
  name                = var.app_service_name
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name
  service_plan_id     = azurerm_service_plan.main.id

  site_config {
    always_on = true
    application_stack {
      dotnet_version = "10.0"
    }
  }

  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE" = "1"
  }

  tags = {
    Environment = "Development"
    ManagedBy   = "Terraform"
    Purpose     = "AZ-400 Training"
  }
}

# Outputs
output "webapp_name" {
  description = "Name of the created web app"
  value       = azurerm_linux_web_app.main.name
}

output "webapp_url" {
  description = "Default hostname of the web app"
  value       = "https://${azurerm_linux_web_app.main.default_hostname}"
}

output "resource_group_name" {
  description = "Name of the resource group"
  value       = data.azurerm_resource_group.main.name
}