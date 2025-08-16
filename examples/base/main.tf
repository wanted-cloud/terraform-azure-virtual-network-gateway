module "template" {
    source = "../.."

    name   = "test-vnet-gateway"
    resource_group_name = "example-rg"

    ip_configurations = [{
      virtual_network_name = "example-vnet"
    }]
}