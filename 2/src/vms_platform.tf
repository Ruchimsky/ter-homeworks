###cloud vars
variable "vm_web_template" {
  type = string
  description = "Шаблон ВМ"
  default = "ubuntu-2004-lts"
}

variable "vm_web_name" {
  type = string
  description = "Имя ВМ"
  default = "netology-develop-platform-web"
}

variable "vm_web_platform_id" {
  type = string
  description = "platform_id"
  default = "standard-v3"
}

/*variable "vm_web_cores" {
  type = number
  description = "Количество ядер"
  default = 2
}

variable "vm_web_memory" {
  type = number
  description = "Количество RAM"
  default = 1
}

variable "vm_web_core_fraction" {
  type = number
  description = "core_fraction"
  default = 20
}*/

variable "vms_resources" {
  type = map(object({
    cores        = number
    memory       = number
    core_fraction = number
  }))

  default = {
    web = {
      cores        = 2
      memory       = 1
      core_fraction = 20
    },
    db = {
      cores        = 2
      memory       = 2
      core_fraction = 20
    }
  }
}

variable "vms_metadata" {
  type = map(object({
    serial_port_enable = number
    ssh_keys           = string
    fqdn               = string
  }))

  default = {
    web = {
      serial_port_enable = 1
      ssh_keys           = "null"
      fqdn               = "web.mydomain.com"
    },
    db = {
      serial_port_enable = 1
      ssh_keys           = "null"
      fqdn               = "db.mydomain.com"
    }
  }
}

# vm_db_


variable "vm_db_name" {
  type = string
  description = "Имя ВМ"
  default = "netology-develop-platform-db"
}

variable "vm_db_platform_id" {
  type = string
  description = "platform_id"
  default = "standard-v3"
}

variable "vm_db_cores" {
  type = number
  description = "Количество ядер"
  default = 2
}

variable "vm_db_memory" {
  type = number
  description = "Количество RAM"
  default = 2
}

variable "vm_db_core_fraction" {
  type = number
  description = "core_fraction"
  default = 20
}