variable "name" {
  description = "Pod name, used to set the nam"
  default     = "ambassador"
}

variable "namespace_create" {
  description = "Create the namespace, must set a unique namespace_name"
  default     = false
}

variable "namespace_name" {
  description = "Kubernetes namespace name"
  default     = "default"
}

variable "ambassador_image" {
  default     = "quay.io/datawire/ambassador"
  description = "Ambassador_image	Image"
}

variable "ambassador_image_tag" {
  default     = "0.50.3"
  description = "Ambassador_image image tag"
}

variable "cluster_role_name" {
  description = "Set cluster rolne name, defaults to name"
  default     = ""
}

variable "image_pull_policy" {
  description = "Image pull policy"
  default     = "IfNotPresent"
}

variable "image_pull_secrets" {
  description = "Image pull secrets"
  default     = []
  type        = list(string)
}

variable "daemon_set" {
  default     = false
  description = "If true Create a daemonSet. By default Deployment controller will be created"
}

variable "volumes" {
  description = "Volumes for the ambassador service"
  default     = []
  type        = list(string)
}

variable "volume_mounts" {
  description = "Volume mounts for the ambassador service"
  default     = []
  type        = list(string)
}

variable "resources_requests_cpu" {
  description = "CPU requests"
  default     = "200m"
}

variable "resources_requests_memory" {
  description = "memory requests"
  default     = "500Mi"
}

variable "resources_limits_cpu" {
  description = "CPU limit"
  default     = "1"
}

variable "resources_limits_memory" {
  description = "memory limit"
  default     = "1Gi"
}

variable "rbac_create" {
  default     = true
  description = "If true, create and use RBAC resources"
}

variable "service_account_create" {
  default     = true
  description = "If true, create a new service account"
}

variable "service_account_name" {
  default     = ""
  description = "Service account to be used"
}

variable "ambassador_namespace_name" {
  description = "Set the AMBASSADOR_NAMESPACE environment variable"
  default     = "metadata.namespace"
}

variable "ambassador_debug" {
  description = "Set the AMBASSADOR_DEBUG environment variable"
  default     = false
}

variable "ambassador_id" {
  default     = "default"
  description = "Set the identifier of the Ambassador instance"
}

variable "loadbalancer_service_enable" {
  description = "Enable the loadbalancer service"
  default     = true
}

variable "loadbalancer_service_target_ports_http" {
  description = "Sets the targetPort that maps to the service's cleartext port"
  default     = 80
}

variable "loadbalancer_service_target_ports_https" {
  description = "Sets the targetPort that maps to the service's TLS port"
  default     = 443
}

variable "loadbalancer_service_type" {
  description = "Service type to be used"
  default     = "LoadBalancer"
}

## TODO - Add ability to specify NodePort
# variable "loadbalancer_service_node_port" {
#   description = "If explicit Nodeport is required"
#   default = ""
# }

variable "loadbalancer_service_ip" {
  description = "IP address to assign (if cloud provider supports it)"
  default     = ""
}

variable "loadbalancer_service_annotations" {
  description = "Annotations to apply to Ambassador loadbalancer service"
  default     = {}
  type        = map(string)
}

variable "loadbalancer_service_source_ranges" {
  description = "Passed to cloud provider load balancer if created (e.g: AWS ELB)"
  default     = ""
}

variable "admin_service_enable" {
  description = "Enable the admin service for Ambassador's admin UI"
  default     = true
}

## TODO - Add ability to specify NodePort
# variable "admin_service_node_port" {
#   description = "If explicit Nodeport is required"
#   default = ""
# }

variable "admin_service_annotations" {
  description = "Annotations to apply to Ambassador loadbalancer service"
  default     = {}
  type        = map(string)
}

variable "admin_service_type" {
  description = "Ambassador's admin service type to be used"
  default     = "ClusterIP"
}

variable "exporter_configuration" {
  description = "	Prometheus exporter configuration in YALM format"
  default     = ""
}

variable "exporter_image" {
  description = "	Prometheus exporter image"
  default     = "prom/statsd-exporter"
}

variable "exporter_image_tag" {
  description = "	Prometheus exporter image tag"
  default     = "v0.6.0"
}

variable "timing_restart" {
  description = "The minimum number of seconds between Envoy restarts"
  default     = ""
}

variable "timing_drain" {
  description = "The number of seconds that the Envoy will wait for open connections to drain on a restart"
  default     = ""
}

variable "timing_shutdown" {
  description = "The number of seconds that Ambassador will wait for the old Envoy to clean up and exit on a restart"
  default     = ""
}

variable "lables_global" {
  description = "Additional global lables to be applied, list of maps"
  default     = []
  type        = list(string)
}

variable "autoscaling_min_replicas" {
  description = "This field sets minimum autoscaling replica count"
  default     = 3
}

variable "autoscaling_max_replicas" {
  description = "This field sets maximum autoscaling replica count"
  default     = 6
}

variable "autoscaling_target_cpu_utilization_percentage" {
  description = "Configure the target cpu utilization percentage for each container"
  default     = 50
}

