/*
 * # wanted-cloud/terraform-azure-virtual-network-gateway
 * 
 * Terraform building block module managing Azure Virtual Network Gateway and its components.
 */

resource "azurerm_virtual_network_gateway" "this" {
  name                = var.name
  location            = var.location != "" ? var.location : data.azurerm_resource_group.this.location
  resource_group_name = data.azurerm_resource_group.this.name

  type     = var.type
  sku      = var.sku
  vpn_type = var.vpn_type

  active_active = var.active_active
  enable_bgp    = var.enable_bgp

  default_local_network_gateway_id = var.default_local_network_gateway_id != "" ? var.default_local_network_gateway_id : null
  edge_zone                        = var.edge_zone != "" ? var.edge_zone : null
  generation                       = var.generation != "" ? var.generation : null

  private_ip_address_enabled            = var.private_ip_address_enabled
  bgp_route_translation_for_nat_enabled = var.bgp_route_translation_for_nat_enabled
  dns_forwarding_enabled                = var.dns_forwarding_enabled
  ip_sec_replay_protection_enabled      = var.ip_sec_replay_protection_enabled
  remote_vnet_traffic_enabled           = var.remote_vnet_traffic_enabled
  virtual_wan_traffic_enabled           = var.virtual_wan_traffic_enabled

  tags = merge(local.metadata.tags, var.tags)

  dynamic "ip_configuration" {
    for_each = { for config in var.ip_configurations : config.name => config }
    content {
      name                          = ip_configuration.value.name
      public_ip_address_id          = ip_configuration.value.public_ip_address_name != "" ? data.azurerm_public_ip.this[ip_configuration.value.name].id : null
      private_ip_address_allocation = ip_configuration.value.private_ip_address_allocation
      subnet_id                     = azurerm_subnet.this[ip_configuration.value.name]["id"]
    }
  }

  vpn_client_configuration {
    address_space = ["10.2.0.0/24"]
  }
}