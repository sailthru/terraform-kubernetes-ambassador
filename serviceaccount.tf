resource "kubernetes_service_account" "this" {
  count = "${var.service_account_create  ? 1 : 0}"
  metadata {
    name = "${local.service_account_name}"
    namespace = "${var.namespace_name}"
  }
  depends_on = ["kubernetes_namespace.this"]
}
