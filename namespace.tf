resource "kubernetes_namespace" "this" {
  count = var.namespace_create ? 1 : 0

  metadata {
    annotations = {
      name = var.namespace_name
    }

    labels = {
      terrafrom = "true",
      app       = var.name
    }

    name = var.namespace_name
  }
}

