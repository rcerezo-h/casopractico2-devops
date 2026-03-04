variable "location" {
  description = "Azure region"
  default     = "Sweden Central"
}

variable "resource_group_name" {
  description = "Resource Group name"
  default     = "rg-casopractico2"
}

variable "environment" {
  description = "Environment tag"
  default     = "casopractico2"
}

variable "vm_admin_username" {
  description = "Admin username VM"
  default     = "azureuser"
}

variable "vm_size" {
  description = "VM size"
  default     = "Standard_B2as_v2"
}

variable "vm_location" {
  description = "Azure region for VM/network resources (can differ from RG/ACR location)"
  default     = "swedencentral"
}

variable "vnet_cidr" {
  description = "VNet CIDR"
  default     = "10.10.0.0/16"
}

variable "subnet_cidr" {
  description = "Subnet CIDR"
  default     = "10.10.1.0/24"
}