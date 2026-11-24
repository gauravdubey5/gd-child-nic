variable "network_interface" {
  description = "A mapping of network interface names to their properties."
  type = map(object({
    name                          = string
    location                      = string
    resource_group_name           = string
    subnet_name                   = string
    virtual_network_name          = string
    public_ip_name                = string
    ip_config_name                = string
    private_ip_address_allocation = string
  }))
}
