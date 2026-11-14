# gd-child-nic: Azure Network Interface Terraform Module

This child module creates and manages an Azure Network Interface (NIC) with configurable IP configurations, accelerated networking, and IP forwarding.

Part of the **Azure Parent–Child Infrastructure Architecture** under GitHub account `gauravdubey5`.

## Features

- Support for single and multiple IP configurations (Primary and Secondary)
- Dynamic and Static private IP allocations
- Public IP association support (`gd-child-public-ip`)
- Accelerated Networking support for high-throughput workloads
- Compatible with Terraform `>= 1.5.0` and AzureRM provider `>= 3.75.0, < 5.0.0`

## Prerequisites

- Existing Resource Group (`gd-child-rg`)
- Existing Subnet (`gd-child-subnet`)

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `name` | Name of the Network Interface (1-80 chars) | `string` | n/a | yes |
| `resource_group_name` | Name of the parent Resource Group | `string` | n/a | yes |
| `location` | Azure Region for deployment | `string` | n/a | yes |
| `ip_configurations` | List of IP configurations | `list(object)` | n/a | yes |
| `accelerated_networking_enabled` | Enable Accelerated Networking | `bool` | `false` | no |
| `ip_forwarding_enabled` | Enable IP Forwarding | `bool` | `false` | no |
| `internal_dns_name_label` | Internal DNS name label | `string` | `null` | no |
| `dns_servers` | Custom DNS servers list | `list(string)` | `[]` | no |
| `tags` | Map of tags applied to the NIC | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| `id` | The Resource ID of the Network Interface |
| `name` | The Name of the Network Interface |
| `private_ip_address` | The primary private IP address |
| `private_ip_addresses` | The list of assigned private IP addresses |

## Example Usage

```hcl
module "nic" {
  source = "git::https://github.com/gauravdubey5/gd-child-nic.git?ref=v1.0.0"

  name                = "nic-vm-dev-001"
  resource_group_name = module.rg.name
  location            = module.rg.location

  ip_configurations = [
    {
      name                          = "ipconfig1"
      subnet_id                     = module.subnet["snet-workload-dev-01"].id
      private_ip_address_allocation = "Dynamic"
      primary                       = true
    }
  ]

  tags = {
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}
```

## Security Considerations

- Leave `ip_forwarding_enabled = false` unless configuring a firewall or router NVA.
- Do not attach public IPs directly to NICs if the workload can sit behind an internal load balancer or reverse proxy.

## Cost Considerations

- Network Interfaces carry **$0.00 / month** base cost in Azure.

## Testing & Verification

```bash
terraform fmt -check
terraform init -backend=false
terraform validate
terraform test
```
