resource "kubernetes_config_map" "this" {
  metadata {
    name      = "${var.name}-config"
    namespace = var.namespace_name

    labels = {
      terrafrom = "true",
      app       = var.name
    }
  }

  data = {
    exporterConfiguration = var.exporter_configuration
  }

  depends_on = [kubernetes_namespace.this]
}

