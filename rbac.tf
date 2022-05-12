resource "kubernetes_cluster_role" "this" {
  count = var.rbac_create ? 1 : 0

  metadata {
    name = local.cluster_role_name

    labels = {
      terrafrom = "true"
      app       = var.name
    }
  }

  rule {
    api_groups = [""]
    resources  = ["endpoints", "namespaces", "secrets", "services"]
    verbs      = ["get", "list", "watch"]
  }
  rule {
    api_groups = ["getambassador.io"]
    resources  = ["*"]
    verbs      = ["get", "list", "watch"]
  }
  rule {
    api_groups = ["apiextensions.k8s.io"]
    resources  = ["customresourcedefinitions"]
    verbs      = ["get", "list", "watch"]
  }
  rule {
    api_groups = ["networking.internal.knative.dev"]
    resources  = ["clusteringresses", "ingresses"]
    verbs      = ["get", "list", "watch"]
  }
  rule {
    api_groups = ["networking.internal.knative.dev"]
    resources  = ["ingresses/status", "clusteringresses/status"]
    verbs      = ["update"]
  }
  rule {
    api_groups = ["extensions"]
    resources  = ["ingresses"]
    verbs      = ["get", "list", "watch"]
  }
  rule {
    api_groups = ["extensions"]
    resources  = ["ingresses/status"]
    verbs      = ["update"]
  }
  rule {
    api_groups = [""]
    resources  = ["configmaps"]
    verbs      = ["create", "update", "patch", "get", "list", "watch"]
  }
  rule {
    api_groups = ["extensions", "networking.k8s.io"]
    resources  = ["ingressclasses", "ingresses"]
    verbs      = ["get", "list", "watch"]
  }
}

resource "kubernetes_cluster_role_binding" "this" {
  count = var.rbac_create ? 1 : 0

  lifecycle {
    ignore_changes = [subject.0.api_group]
  }

  metadata {
    name = local.cluster_role_name

    labels = {
      terrafrom = "true"
      app       = var.name
    }
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    name      = local.cluster_role_name
    kind      = "ClusterRole"
  }

  subject {
    kind      = "ServiceAccount"
    name      = local.service_account_name
    namespace = var.namespace_name
  }

  depends_on = [
    kubernetes_namespace.this,
    kubernetes_cluster_role.this,
  ]
}

