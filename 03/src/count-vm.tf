data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_template
}

resource "yandex_compute_instance" "vm_count" {
  count = 2
  name        = "vm-${count.index}"
  platform_id = "standard-v3"

  depends_on = [ yandex_compute_instance.vm-for_each ]

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
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