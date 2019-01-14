resource "kubernetes_cluster_role" "this" {
  count = "${var.rbac_create  ? 1 : 0}"
  metadata {
    name = "${local.cluster_role_name}"
    labels = [
      {
        terrafrom = "true"
      },
      {
        app = "${var.name}"
      }
    ]
  }

  rule = [
    {
      api_groups = [""]
      resources  = ["services"]
      verbs      = ["get", "list", "watch"]
    },
    {
      api_groups = [""]
      resources  = ["configmaps"]
      verbs      = ["create", "update", "patch", "get", "list", "watch"]
    },
   {
      api_groups = [""]
      resources  = ["secrets"]
      verbs      = ["get", "list", "watch"]
    }
  ]
}

resource "kubernetes_cluster_role_binding" "this" {
  count = "${var.rbac_create  ? 1 : 0}"
  lifecycle {
    ignore_changes = ["subject.0.api_group"]
  }

  metadata {
    name = "${local.cluster_role_name}"
    labels = [
      {
        terrafrom = "true"
      },
      {
        app = "${var.name}"
      }
    ]
  }

	role_ref {
    api_group = "rbac.authorization.k8s.io"
		name  = "${local.cluster_role_name}"
		kind  = "ClusterRole"
  }

  subject {
    kind =  "ServiceAccount"
    name = "${local.service_account_name}"
    namespace =  "${var.namespace_name}"
  }

  depends_on = ["kubernetes_namespace.this", "kubernetes_cluster_role.this"]
}
