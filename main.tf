resource "azurerm_network_interface" "network_interfaces" {
    for_each = var.network_interface
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                          = each.value.ip_config_name
    subnet_id                     = data.azurerm_subnet.subnets[each.key].id
    public_ip_address_id          = data.azurerm_public_ip.public_ips[each.key].id
    private_ip_address_allocation = each.value.private_ip_address_allocation
}
}