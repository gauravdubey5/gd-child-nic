mock_provider "azurerm" {}

run "verify_nic_plan" {
  command = plan

  variables {
    name                           = "nic-test-unit-001"
    resource_group_name            = "rg-test-nic"
    location                       = "eastus2"
    accelerated_networking_enabled = true
    ip_configurations = [
      {
        name                          = "ipconfig1"
        subnet_id                     = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-test-nic/providers/Microsoft.Network/virtualNetworks/vnet-test/subnets/snet-test"
        private_ip_address_allocation = "Dynamic"
        primary                       = true
      }
    ]
    tags = {
      Environment = "test"
    }
  }

  assert {
    condition     = azurerm_network_interface.nic.name == "nic-test-unit-001"
    error_message = "NIC name did not match expected value"
  }

  assert {
    condition     = azurerm_network_interface.nic.accelerated_networking_enabled == true
    error_message = "Accelerated networking should be enabled"
  }

  assert {
    condition     = length(azurerm_network_interface.nic.ip_configuration) == 1
    error_message = "Should have 1 IP configuration"
  }
}
