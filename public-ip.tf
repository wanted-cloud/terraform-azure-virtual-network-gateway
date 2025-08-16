data "azurerm_public_ip" "this" {
  for_each            = { for config in var.ip_configurations : config.name => config if config.public_ip_address_name != "" }
  name                = each.value.public_ip_address_name
  resource_group_name = each.value.public_ip_address_resource_group_name != "" ? each.value.public_ip_address_resource_group_name : data.azurerm_resource_group.this.name
}