resource "kubernetes_service" "this_loadbalancer" {
  count = "${var.loadbalancer_service_enable  ? 1 : 0}"
  metadata = [
    {
      annotations = "${var.loadbalancer_service_annotations}"
      name = "${var.name}"
      namespace =  "${var.namespace_name}"

      labels  {
          terrafrom = "true"
        }

        labels {
          app = "${var.name}"
        }
    }
  ]

  spec = [
    {
      type = "${var.loadbalancer_service_type}"
      port = [
        {
          name = "http"
          protocol = "TCP"
          port = 80
          target_port = "${var.loadbalancer_service_target_ports_http}"
        },
        {
          name = "https"
          protocol = "TCP"
          port = 443
          target_port = "${var.loadbalancer_service_target_ports_https}"
        }
      ]
      selector {
        app = "${var.name}"
      }
      session_affinity = "None"
    }
  ]
  depends_on = ["kubernetes_namespace.this"]
}