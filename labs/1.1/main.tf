
resource "azurerm_resource_group" "lab" {
    name     = "lab-1-0"
    location = "northeurope"
}

resource "random_id" "lab" {
    keepers = {
        resource_group = "${azurerm_resource_group.lab.name}"
    }

    byte_length = 2
}

