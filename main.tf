resource "azurerm_network_interface" "nic" {
  name                           = var.name
  location                       = var.location
  resource_group_name            = var.resource_group_name
  accelerated_networking_enabled = var.accelerated_networking_enabled
  ip_forwarding_enabled          = var.ip_forwarding_enabled
  internal_dns_name_label        = var.internal_dns_name_label
  dns_servers                    = length(var.dns_servers) > 0 ? var.dns_servers : null
  tags                           = var.tags

  dynamic "ip_configuration" {
    for_each = var.ip_configurations
    content {
      name                          = ip_configuration.value.name
      subnet_id                     = ip_configuration.value.subnet_id
      private_ip_address_allocation = ip_configuration.value.private_ip_address_allocation
      private_ip_address            = ip_configuration.value.private_ip_address
      public_ip_address_id          = ip_configuration.value.public_ip_address_id
      primary                       = ip_configuration.value.primary
    }
  }
}
