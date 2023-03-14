output "name" {
    value = "${azurerm_linux_function_app.lab.default_hostname}"
}