
resource "random_id" "lab" {
  keepers = {
    resource_group  = "${var.resource_group_name}"
  }

  byte_length = 2
}


resource "azurerm_service_plan" "lab" {
  name                = "lab-plan"
  location            = "${var.resource_group_location}"
  resource_group_name = "${var.resource_group_name}"
  os_type             = "Linux"
  sku_name            = "Y1"
}

resource "azurerm_storage_account" "lab" {
  name                     = "lab${random_id.lab.dec}store"
  resource_group_name      = "${var.resource_group_name}"
  location                 = "${var.resource_group_location}"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}


resource "azurerm_linux_function_app" "lab" {
  name                       = "lab${random_id.lab.dec}"
  location                   = "${var.resource_group_location}"
  resource_group_name        = "${var.resource_group_name}"
  service_plan_id            = "${azurerm_service_plan.lab.id}"
  storage_account_name       = "${azurerm_storage_account.lab.name}"
  storage_account_access_key = "${azurerm_storage_account.lab.primary_access_key}"
  
  site_config {}
}