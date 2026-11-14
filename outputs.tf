output "id" {
  description = "The ID of the Network Interface."
  value       = azurerm_network_interface.nic.id
}

output "name" {
  description = "The Name of the Network Interface."
  value       = azurerm_network_interface.nic.name
}

output "private_ip_address" {
  description = "The first private IP address of the network interface."
  value       = azurerm_network_interface.nic.private_ip_address
}

output "private_ip_addresses" {
  description = "The private IP addresses of the network interface."
  value       = azurerm_network_interface.nic.private_ip_addresses
}
