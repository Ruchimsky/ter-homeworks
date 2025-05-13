resource "yandex_compute_instance" "vm-for_each" {
  for_each = var.vms_for_each
  name        = each.value.name
  platform_id = "standard-v3"
  resources {
    cores         = each.value.cores
    memory        = each.value.memory
    core_fraction = each.value.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = each.value.disk_volume
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
    security_group_ids = [yandex_vpc_security_group.example.id]
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${local.ssh_public_key}"
  }
}

variable "vms_for_each" {
  description = "VM definitions"
  type = map(object({
    name                = string
    cores               = number
    memory              = number
    core_fraction       = number
    disk_volume         = number

  }))

  default = {
    "main" = {
      name               = "main"
      cores              = 2
      memory             = 2
      core_fraction      = 20
      disk_volume        = 22
    }

    "replica" = {
      name               = "replica"
      cores              = 4
      memory             = 4
      core_fraction      = 50
      disk_volume        = 20
    }
  }
}