data "azurerm_subnet" "this" {
  for_each = { for config in var.ip_configurations : config.name => config }
  // As this is mandatory name for Gateway Subnet, we can use a hardcoded value.
  name                 = "GatewaySubnet"
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.virtual_network_resource_group_name != "" ? each.value.virtual_network_resource_group_name : data.azurerm_resource_group.this.name
}