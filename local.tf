locals {
  cluster_role_name = "${
    var.cluster_role_name == "" ?
    var.name : var.cluster_role_name
  }"

  service_account_name = "${
    var.service_account_name == "" ?
    var.name : var.service_account_name
  }"
}
