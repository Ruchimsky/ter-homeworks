resource "yandex_compute_disk" "data_disk" {
  count = 3

  name     = "data-disk-${count.index}"
  type     = "network-hdd"
  zone     = "ru-central1-a"
  size     = 1
}

resource "yandex_compute_instance" "storage" {
  name        = "storage"
  platform_id = "standard-v1"
  zone        = "ru-central1-a"

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

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
    security_group_ids = [yandex_vpc_security_group.example.id]
  }

  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.data_disk[*].id

    content {
      disk_id = secondary_disk.value
      auto_delete = true
    }
  }

  metadata = {
    ssh-keys = "ubuntu:${local.ssh_public_key}"
  }
}