output "acr_name" {
  value = azurerm_container_registry.acr.name
}

output "acr_login_server" {
  value = azurerm_container_registry.acr.login_server
}

output "acr_admin_username" {
  value     = azurerm_container_registry.acr.admin_username
  sensitive = true
}

output "acr_admin_password" {
  value     = azurerm_container_registry.acr.admin_password
  sensitive = true
}

output "vm_public_ip" {
  value = azurerm_public_ip.vm_pip.ip_address
}

output "vm_admin_username" {
  value = var.vm_admin_username
}

output "vm_ssh_private_key_pem" {
  value     = tls_private_key.vm_ssh.private_key_pem
  sensitive = true
}