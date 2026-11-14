variable "name" {
  description = "The name of the Network Interface. Must be between 1 and 80 characters."
  type        = string

  validation {
    condition     = length(var.name) >= 1 && length(var.name) <= 80
    error_message = "NIC name must be between 1 and 80 characters."
  }
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the Network Interface."
  type        = string
}

variable "location" {
  description = "The Azure region where the Network Interface should exist."
  type        = string
}

variable "ip_configurations" {
  description = "One or more IP configuration blocks for the Network Interface."
  type = list(object({
    name                          = string
    subnet_id                     = string
    private_ip_address_allocation = string
    private_ip_address            = optional(string)
    public_ip_address_id          = optional(string)
    primary                       = optional(bool, true)
  }))

  validation {
    condition     = length(var.ip_configurations) > 0
    error_message = "At least one ip_configuration must be configured."
  }

  validation {
    condition = alltrue([
      for ip in var.ip_configurations :
      contains(["Dynamic", "Static"], ip.private_ip_address_allocation)
    ])
    error_message = "private_ip_address_allocation must be 'Dynamic' or 'Static'."
  }
}

variable "accelerated_networking_enabled" {
  description = "Should Accelerated Networking be enabled? Defaults to false."
  type        = bool
  default     = false
}

variable "ip_forwarding_enabled" {
  description = "Should IP Forwarding be enabled? Defaults to false."
  type        = bool
  default     = false
}

variable "internal_dns_name_label" {
  description = "The relative DNS name for this Network Interface."
  type        = string
  default     = null
}

variable "dns_servers" {
  description = "A list of IP Addresses defining the DNS Servers which should be used for this Network Interface."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}
