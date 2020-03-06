resource "kubernetes_service_account" "this" {
  count = var.service_account_create ? 1 : 0

  # automount_service_account_token = true
  metadata {
    name      = local.service_account_name
    namespace = var.namespace_name

    labels = {
      terrafrom = "true"
      app       = var.name
    }
  }

  depends_on = [kubernetes_namespace.this]
}

