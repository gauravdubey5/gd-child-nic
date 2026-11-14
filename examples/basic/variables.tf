variable "name" {
  type    = string
  default = "nic-example-basic"
}

variable "resource_group_name" {
  type    = string
  default = "rg-example-basic"
}

variable "location" {
  type    = string
  default = "eastus2"
}

variable "ip_configurations" {
  type = list(object({
    name                          = string
    subnet_id                     = string
    private_ip_address_allocation = string
    private_ip_address            = optional(string)
    public_ip_address_id          = optional(string)
    primary                       = optional(bool, true)
  }))
  default = [
    {
      name                          = "ipconfig1"
      subnet_id                     = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-example-basic/providers/Microsoft.Network/virtualNetworks/vnet-example/subnets/snet-example"
      private_ip_address_allocation = "Dynamic"
      primary                       = true
    }
  ]
}

variable "tags" {
  type = map(string)
  default = {
    Environment = "example"
  }
}
