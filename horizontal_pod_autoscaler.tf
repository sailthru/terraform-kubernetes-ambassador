# Create a horizontal pod autoscaler for the service when autoscaling is enabled
resource "kubernetes_horizontal_pod_autoscaler" "ambassador" {
  metadata {
    name      = var.name
    namespace = var.namespace_name
  }

  spec {
    min_replicas = var.autoscaling_min_replicas
    max_replicas = var.autoscaling_max_replicas

    target_cpu_utilization_percentage = var.autoscaling_target_cpu_utilization_percentage

    scale_target_ref {
      api_version = "apps/v1"
      kind        = "Deployment"
      name        = var.name
    }
  }

  depends_on = [
    kubernetes_deployment.this,
  ]
}
