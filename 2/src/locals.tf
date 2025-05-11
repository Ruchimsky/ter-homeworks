locals {
  project = "netology-develop-platform"
  vm_1 = "web"
  vm_2 = "db"
  vm_web_name = "${local.project}-${local.vm_1}"
  vm_db_name = "${local.project}-${local.vm_2}"
}