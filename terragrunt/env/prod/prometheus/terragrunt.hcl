include "remote_state" {
  path = find_in_parent_folders("backend.hcl")
}

include "provider" {
  path = find_in_parent_folders("provider.hcl")
}

dependency "eks" {
  config_path = "../eks"
}

terraform {
  source = "../../../modules//helm"
}

locals {
  common_vars = yamldecode(file("${find_in_parent_folders("common-vars.yml")}"))
}

inputs = {
  namespace        = "monitoring"
  release_namename = "prometheus"
  chart            = "kube-prometheus-stack"
  chart_version     = "72.2.0"  # Specify the version you want to use
  repository       = "https://prometheus-community.github.io/helm-charts"
  create_namespace = true
  eks_cluster_name = dependency.eks.outputs.aws_eks_cluster_name

  values = [
    <<-EOF
    prometheus:
      prometheusSpec:
        serviceMonitorSelectorNilUsesHelmValues: false
        serviceMonitorSelector: {}
        serviceMonitorNamespaceSelector: {}
        resources:
          requests:
            memory: "400Mi"
            cpu: "100m"
          limits:
            memory: "1Gi"
            cpu: "500m"

    grafana:
      adminPassword: "admin"  # Change this in production
      service:
        type: LoadBalancer
      resources:
        requests:
          memory: "100Mi"
          cpu: "100m"
        limits:
          memory: "200Mi"
          cpu: "200m"
      dashboardProviders:
        dashboardproviders.yaml:
          apiVersion: 1
          providers:
          - name: 'default'
            orgId: 1
            folder: ''
            type: file
            disableDeletion: false
            editable: true
            options:
              path: /var/lib/grafana/dashboards
      dashboards:
        default:
          image-api:
            gnetId: null
            revision: null
            datasource: Prometheus
            editable: true
    EOF
  ]

  list_set = [
    {
      name  = "prometheus.prometheusSpec.serviceMonitorSelectorNilUsesHelmValues"
      value = "false"
    },
    {
      name  = "prometheus.prometheusSpec.serviceMonitorSelector"
      value = "{}"
    },
    {
      name  = "prometheus.prometheusSpec.serviceMonitorNamespaceSelector"
      value = "{}"
    }
  ]

  # wait = true
  # timeout = 600
}
