resource "kubernetes_service" "this_admin" {
  count = "${var.admin_service_enable  ? 1 : 0}"
  metadata = [
    {
      annotations = "${var.admin_service_annotations}"
      name = "${var.name}-admin"
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
      type = "${var.admin_service_type}"
      port = [
        {
          name = "${var.name}-admin" 
          port = 8877
          protocol = "TCP"
          target_port = 8877
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