provider "azurerm" {
  features {}
  subscription_id = var.subscription_id

  # The deployment service principal does not have permission to register
  # resource providers at the subscription scope, so opt out of automatic
  # registration. Required providers must be registered by an administrator.
  resource_provider_registrations = "none"
}
