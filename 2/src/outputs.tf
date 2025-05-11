/* output "platform" {
  value = { 
    name = yandex_compute_instance.platform_web.name
    external_ip = yandex_compute_instance.platform_web.network_interface.0.nat_ip_address
    fqdn = yandex_compute_instance.platform_web.fqdn
  }
}

output "netology-develop-platform-db" {
  value = { 
    name = yandex_compute_instance.platform_db.name
    external_ip = yandex_compute_instance.platform_db.network_interface.0.nat_ip_address
    fqdn = yandex_compute_instance.platform_db.fqdn
  }
}*/
output "vm_details" {
  value = [
    {
      instance_name = yandex_compute_instance.platform_web.name
      external_ip   = yandex_compute_instance.platform_web.network_interface[0].nat_ip_address
      fqdn          = yandex_compute_instance.platform_web.fqdn
    },
    {
      instance_name = yandex_compute_instance.platform_db.name
      external_ip   = yandex_compute_instance.platform_db.network_interface[0].nat_ip_address
      fqdn          = yandex_compute_instance.platform_db.fqdn
    }
  ]
}