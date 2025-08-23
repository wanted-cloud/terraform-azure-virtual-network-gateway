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
      subnet_id                     = data.azurerm_subnet.this[ip_configuration.value.name]["id"]
    }
  }

  dynamic "vpn_client_configuration" {
    for_each = var.vpn_client_configuration != null ? [var.vpn_client_configuration] : []
    content {
      address_space         = vpn_client_configuration.value.address_space
      radius_server_address = vpn_client_configuration.value.radius_server_address != "" ? vpn_client_configuration.value.radius_server_address : null
      radius_server_secret  = vpn_client_configuration.value.radius_server_secret != "" ? vpn_client_configuration.value.radius_server_secret : null
      vpn_auth_types        = vpn_client_configuration.value.vpn_auth_types
      vpn_client_protocols  = vpn_client_configuration.value.vpn_client_protocols

      aad_tenant   = try(vpn_client_configuration.value.aad_tenant, null)
      aad_issuer   = try(vpn_client_configuration.value.aad_issuer, null)
      aad_audience = try(vpn_client_configuration.value.aad_audience, null)

      dynamic "revoked_certificate" {
        for_each = var.vpn_client_configuration.revoked_certificates
        content {
          name       = revoked_certificate.value.name
          thumbprint = revoked_certificate.value.thumbprint
        }
      }

      dynamic "root_certificate" {
        for_each = var.vpn_client_configuration.root_certificates
        content {
          name             = root_certificate.value.name
          public_cert_data = root_certificate.value.public_cert_data
        }
      }
    }
  }

  timeouts {
    create = try(
      local.metadata.resource_timeouts["azurerm_virtual_network_gateway"]["create"],
      local.metadata.resource_timeouts["default"]["create"]
    )
    read = try(
      local.metadata.resource_timeouts["azurerm_virtual_network_gateway"]["read"],
      local.metadata.resource_timeouts["default"]["read"]
    )
    update = try(
      local.metadata.resource_timeouts["azurerm_virtual_network_gateway"]["update"],
      local.metadata.resource_timeouts["default"]["update"]
    )
    delete = try(
      local.metadata.resource_timeouts["azurerm_virtual_network_gateway"]["delete"],
      local.metadata.resource_timeouts["default"]["delete"]
    )
  }
}