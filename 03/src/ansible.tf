locals {
  webservers = {
    for name, vm in yandex_compute_instance.vm-for_each :
    name => {
      ip   = vm.network_interface[0].nat_ip_address
      fqdn = vm.fqdn
    }
  }

  databases = {
    for idx in range(length(yandex_compute_instance.vm_count)) :
    "db-${idx}" => {
      ip   = yandex_compute_instance.vm_count[idx].network_interface[0].nat_ip_address
      fqdn = yandex_compute_instance.vm_count[idx].fqdn
    }
  }

  storage = {
    "storage" = {
      ip   = yandex_compute_instance.storage.network_interface[0].nat_ip_address
      fqdn = yandex_compute_instance.storage.fqdn
    }
  }
}

resource "local_file" "ansible_inventory" {
  filename = "${path.module}/inventory.ini"

  content = templatefile("${path.module}/hosts.tftpl", {
    webservers = local.webservers
    databases  = local.databases
    storage    = local.storage
  })
}