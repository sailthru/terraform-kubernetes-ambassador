# Terraform Kubernetes Ambassador

Terraform module for deploying the Ambassador loadbalancer on Kubernetes.

This module is heavily based on the Datawire Ambassador helm chart `datawire/ambassador`.

# Usage
This is an advanced example showing how to:

* Pass configuration to ambassador
* Use `external-dns` to create the hostname

```hcl
data "template_file" "getambassador_config" {
  template = <<EOF
---
apiVersion: ambassador/v0
kind: Module
name: ambassador
ambassador_id: internal
config:
  diagnostics:
    enabled: false
  service_port: 443
  x_forwarded_proto_redirect: true
---
apiVersion: ambassador/v0
kind:  Module
name:  tls
ambassador_id: internal
config:
  server:
    enabled: true
    redirect_cleartext_from: 80
EOF
}

module "ambassador" {
  source = "sailthru/ambassador/kubernetes"
  loadbalancer_service_annotations = {
    "getambassador.io/config" = "${data.template_file.getambassador_config.rendered}"
  }
}
---

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| admin_service_annotations | Annotations to apply to Ambassador loadbalancer service | map | `<map>` | no |
| admin_service_enable | Enable the admin service for Ambassador's admin UI | string | `true` | no |
| admin_service_type | Ambassador's admin service type to be used | string | `ClusterIP` | no |
| ambassador_id | Set the identifier of the Ambassador instance | string | `default` | no |
| ambassador_image | Ambassador_image	Image | string | `quay.io/datawire/ambassador` | no |
| ambassador_image_tag | Ambassador_image image tag | string | `0.40.2` | no |
| ambassador_namespace_name | Set the AMBASSADOR_NAMESPACE environment variable | string | `metadata.namespace` | no |
| ambassador_namespace_single | Set the AMBASSADOR_SINGLE_NAMESPACE environment variable | string | `false` | no |
| cluster_role_name | Set cluster rolne name, defaults to name | string | `` | no |
| daemon_set | If true Create a daemonSet. By default Deployment controller will be created | string | `false` | no |
| exporter_configuration | Prometheus exporter configuration in YALM format | string | `` | no |
| exporter_image | Prometheus exporter image | string | `prom/statsd-exporter` | no |
| exporter_image_tag | Prometheus exporter image tag | string | `v0.6.0` | no |
| image_pull_policy | Image pull policy | string | `IfNotPresent` | no |
| image_pull_secrets | Image pull secrets | list | `<list>` | no |
| lables_global | Additional global lables to be applied, list of maps | list | `<list>` | no |
| loadbalancer_service_annotations | Annotations to apply to Ambassador loadbalancer service | map | `<map>` | no |
| loadbalancer_service_enable | Enable the loadbalancer service | string | `true` | no |
| loadbalancer_service_ip | IP address to assign (if cloud provider supports it) | string | `` | no |
| loadbalancer_service_source_ranges | Passed to cloud provider load balancer if created (e.g: AWS ELB) | string | `` | no |
| loadbalancer_service_target_ports_http | Sets the targetPort that maps to the service's cleartext port | string | `80` | no |
| loadbalancer_service_target_ports_https | Sets the targetPort that maps to the service's TLS port | string | `443` | no |
| loadbalancer_service_type | Service type to be used | string | `LoadBalancer` | no |
| name | Pod name, used to set the nam | string | `ambassador` | no |
| namespace_create | Create the namespace, must set a unique namespace_name | string | `false` | no |
| namespace_name | Kubernetes namespace name | string | `default` | no |
| rbac_create | If true, create and use RBAC resources | string | `true` | no |
| replica_count | Number of Ambassador replicas | string | `1` | no |
| resources_limits_cpu | CPU limit | string | `1` | no |
| resources_limits_memory | memory limit | string | `1Gi` | no |
| resources_requests_cpu | CPU requests | string | `200m` | no |
| resources_requests_memory | memory requests | string | `500Mi` | no |
| service_account_create | If true, create a new service account | string | `true` | no |
| service_account_name | Service account to be used | string | `` | no |
| timing_drain | The number of seconds that the Envoy will wait for open connections to drain on a restart | string | `` | no |
| timing_restart | The minimum number of seconds between Envoy restarts | string | `` | no |
| timing_shutdown | The number of seconds that Ambassador will wait for the old Envoy to clean up and exit on a restart | string | `` | no |
| volume_mounts | Volume mounts for the ambassador service | list | `<list>` | no |
| volumes | Volumes for the ambassador service | list | `<list>` | no |


```
