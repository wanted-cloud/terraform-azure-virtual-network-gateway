variable "name" {
  description = "The name of the virtual network gateway to be provisioned."
  type        = string
}

variable "location" {
  description = "The location/region where the virtual network gateway will be created."
  type        = string
  default     = ""
}

variable "resource_group_name" {
  description = "The name of the resource group where the virtual network gateway will be created."
  type        = string
}

variable "sku" {
  description = "The SKU of the virtual network gateway."
  type        = string
  default     = "Standard"
}

variable "type" {
  description = "The type of the virtual network gateway (e.g., 'Vpn', 'ExpressRoute')."
  type        = string
  default     = "Vpn"
}

variable "vpn_type" {
  description = "The VPN type of the virtual network gateway (e.g., 'RouteBased', 'PolicyBased')."
  type        = string
  default     = "RouteBased"
}

variable "active_active" {
  description = "Whether the virtual network gateway is active-active."
  type        = bool
  default     = false
}

variable "tags" {
  description = "A map of tags to assign to the virtual network gateway."
  type        = map(string)
  default     = {}

}

variable "enable_bgp" {
  description = "Whether BGP is enabled on the virtual network gateway."
  type        = bool
  default     = false
}

variable "default_local_network_gateway_id" {
  description = "The ID of the default local network gateway to be used for the virtual network gateway."
  type        = string
  default     = ""
}

variable "edge_zone" {
  description = "The edge zone where the virtual network gateway will be created."
  type        = string
  default     = ""

}

variable "generation" {
  description = "The generation of the virtual network gateway (e.g., 'Generation1', 'Generation2' or 'None')."
  type        = string
  default     = "None"
}

variable "private_ip_address_enabled" {
  description = "Whether a private IP address is enabled for the virtual network gateway."
  type        = bool
  default     = false

}

variable "bgp_route_translation_for_nat_enabled" {
  description = "Whether BGP route translation for NAT is enabled on the virtual network gateway."
  type        = bool
  default     = false
}

variable "dns_forwarding_enabled" {
  description = "Whether DNS forwarding is enabled on the virtual network gateway."
  type        = bool
  default     = false
}

variable "ip_sec_replay_protection_enabled" {
  description = "Whether IPsec replay protection is enabled on the virtual network gateway."
  type        = bool
  default     = true
}

variable "remote_vnet_traffic_enabled" {
  description = "Whether remote VNet traffic is enabled on the virtual network gateway."
  type        = bool
  default     = false
}

variable "virtual_wan_traffic_enabled" {
  description = "Whether virtual WAN traffic is enabled on the virtual network gateway."
  type        = bool
  default     = false
}

variable "ip_configurations" {
  description = "List of configuration blocks for the IP configuration of the virtual network gateway."
  type = list(object({
    name                                  = optional(string, "vnetGatewayConfig")
    public_ip_address_name                = optional(string, "")
    public_ip_address_resource_group_name = optional(string, "")
    private_ip_address_allocation         = optional(string, "Dynamic")
    virtual_network_resource_group_name   = optional(string, "")
    virtual_network_name                  = string
  }))
  default = []
}

variable "vpn_client_configuration" {
  description = "Configuration block for the VPN client of the virtual network gateway."
  type = object({
    aad_tenant            = optional(string, "")
    aad_audience          = optional(string, "")
    aad_issuer            = optional(string, "")
    address_space         = list(string)
    radius_server_address = optional(string, "")
    radius_server_secret  = optional(string, "")
    vpn_auth_types        = optional(list(string), ["AAD"])
    vpn_client_protocols  = optional(list(string), ["OpenVPN"])
    root_certificates = optional(list(object({
      name             = string
      public_cert_data = string
    })), [])
    revoked_certificates = optional(list(object({
      name       = string
      thumbprint = string
    })), [])
  })
  default = null
}