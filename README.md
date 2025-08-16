<!-- BEGIN_TF_DOCS -->
# wanted-cloud/terraform-azure-virtual-network-gateway

Terraform building block module managing Azure Virtual Network Gateway and its components.

## Table of contents

- [Requirements](#requirements)
- [Providers](#providers)
- [Variables](#inputs)
- [Outputs](#outputs)
- [Resources](#resources)
- [Usage](#usage)
- [Contributing](#contributing)

## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (>= 1.9)

- <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) (>=4.20.0)

## Providers

The following providers are used by this module:

- <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) (>=4.20.0)

## Required Inputs

The following input variables are required:

### <a name="input_ip_configurations"></a> [ip\_configurations](#input\_ip\_configurations)

Description: List of configuration blocks for the IP configuration of the virtual network gateway.

Type:

```hcl
list(object({
    name                                  = optional(string, "vnetGatewayConfig")
    public_ip_address_name                = optional(string, "")
    public_ip_address_resource_group_name = optional(string, "")
    private_ip_address_allocation         = optional(string, "Dynamic")
    virtual_network_resource_group_name   = optional(string, "")
    virtual_network_name                  = string
  }))
```

### <a name="input_name"></a> [name](#input\_name)

Description: The name of the virtual network gateway to be provisioned.

Type: `string`

### <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name)

Description: The name of the resource group where the virtual network gateway will be created.

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_active_active"></a> [active\_active](#input\_active\_active)

Description: Whether the virtual network gateway is active-active.

Type: `bool`

Default: `false`

### <a name="input_bgp_route_translation_for_nat_enabled"></a> [bgp\_route\_translation\_for\_nat\_enabled](#input\_bgp\_route\_translation\_for\_nat\_enabled)

Description: Whether BGP route translation for NAT is enabled on the virtual network gateway.

Type: `bool`

Default: `false`

### <a name="input_default_local_network_gateway_id"></a> [default\_local\_network\_gateway\_id](#input\_default\_local\_network\_gateway\_id)

Description: The ID of the default local network gateway to be used for the virtual network gateway.

Type: `string`

Default: `""`

### <a name="input_dns_forwarding_enabled"></a> [dns\_forwarding\_enabled](#input\_dns\_forwarding\_enabled)

Description: Whether DNS forwarding is enabled on the virtual network gateway.

Type: `bool`

Default: `false`

### <a name="input_edge_zone"></a> [edge\_zone](#input\_edge\_zone)

Description: The edge zone where the virtual network gateway will be created.

Type: `string`

Default: `""`

### <a name="input_enable_bgp"></a> [enable\_bgp](#input\_enable\_bgp)

Description: Whether BGP is enabled on the virtual network gateway.

Type: `bool`

Default: `false`

### <a name="input_generation"></a> [generation](#input\_generation)

Description: The generation of the virtual network gateway (e.g., 'Generation1', 'Generation2' or 'None').

Type: `string`

Default: `"None"`

### <a name="input_ip_sec_replay_protection_enabled"></a> [ip\_sec\_replay\_protection\_enabled](#input\_ip\_sec\_replay\_protection\_enabled)

Description: Whether IPsec replay protection is enabled on the virtual network gateway.

Type: `bool`

Default: `true`

### <a name="input_location"></a> [location](#input\_location)

Description: The location/region where the virtual network gateway will be created.

Type: `string`

Default: `""`

### <a name="input_metadata"></a> [metadata](#input\_metadata)

Description: Metadata definitions for the module, this is optional construct allowing override of the module defaults defintions of validation expressions, error messages, resource timeouts and default tags.

Type:

```hcl
object({
    resource_timeouts = optional(
      map(
        object({
          create = optional(string, "30m")
          read   = optional(string, "5m")
          update = optional(string, "30m")
          delete = optional(string, "30m")
        })
      ), {}
    )
    tags                     = optional(map(string), {})
    validator_error_messages = optional(map(string), {})
    validator_expressions    = optional(map(string), {})
  })
```

Default: `{}`

### <a name="input_private_ip_address_enabled"></a> [private\_ip\_address\_enabled](#input\_private\_ip\_address\_enabled)

Description: Whether a private IP address is enabled for the virtual network gateway.

Type: `bool`

Default: `false`

### <a name="input_remote_vnet_traffic_enabled"></a> [remote\_vnet\_traffic\_enabled](#input\_remote\_vnet\_traffic\_enabled)

Description: Whether remote VNet traffic is enabled on the virtual network gateway.

Type: `bool`

Default: `false`

### <a name="input_sku"></a> [sku](#input\_sku)

Description: The SKU of the virtual network gateway.

Type: `string`

Default: `"Standard"`

### <a name="input_tags"></a> [tags](#input\_tags)

Description: A map of tags to assign to the virtual network gateway.

Type: `map(string)`

Default: `{}`

### <a name="input_type"></a> [type](#input\_type)

Description: The type of the virtual network gateway (e.g., 'Vpn', 'ExpressRoute').

Type: `string`

Default: `"Vpn"`

### <a name="input_virtual_wan_traffic_enabled"></a> [virtual\_wan\_traffic\_enabled](#input\_virtual\_wan\_traffic\_enabled)

Description: Whether virtual WAN traffic is enabled on the virtual network gateway.

Type: `bool`

Default: `false`

### <a name="input_vpn_client_configuration"></a> [vpn\_client\_configuration](#input\_vpn\_client\_configuration)

Description: Configuration block for the VPN client of the virtual network gateway.

Type:

```hcl
object({
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
```

Default: `null`

### <a name="input_vpn_type"></a> [vpn\_type](#input\_vpn\_type)

Description: The VPN type of the virtual network gateway (e.g., 'RouteBased', 'PolicyBased').

Type: `string`

Default: `"RouteBased"`

## Outputs

The following outputs are exported:

### <a name="output_virtual_network_gateway"></a> [virtual\_network\_gateway](#output\_virtual\_network\_gateway)

Description: The object of the Virtual Network Gateway.

## Resources

The following resources are used by this module:

- [azurerm_virtual_network_gateway.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_gateway) (resource)
- [azurerm_public_ip.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/public_ip) (data source)
- [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) (data source)
- [azurerm_subnet.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) (data source)

## Usage

> For more detailed examples navigate to `examples` folder of this repository.

Module was also published via Terraform Registry and can be used as a module from the registry.

```hcl
module "example" {
  source  = "wanted-cloud/..."
  version = "x.y.z"
}
```

### Basic usage example

The minimal usage for the module is as follows:

```hcl
module "template" {
    source = "../.."

    name   = "test-vnet-gateway"
    resource_group_name = "example-rg"

    ip_configurations = [{
      virtual_network_name = "example-vnet"
    }]
}
```
## Contributing

_Contributions are welcomed and must follow [Code of Conduct](https://github.com/wanted-cloud/.github?tab=coc-ov-file) and common [Contributions guidelines](https://github.com/wanted-cloud/.github/blob/main/docs/CONTRIBUTING.md)._

> If you'd like to report security issue please follow [security guidelines](https://github.com/wanted-cloud/.github?tab=security-ov-file).
---
<sup><sub>_2025 &copy; All rights reserved - WANTED.solutions s.r.o._</sub></sup>
<!-- END_TF_DOCS -->