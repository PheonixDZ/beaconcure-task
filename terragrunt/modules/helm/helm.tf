########################################################
# Helm chart Deployment
########################################################

resource "helm_release" "this" {
  name             = var.release_name
  chart            = var.chart
  version          = var.chart_version
  create_namespace = var.create_namespace
  repository       = var.repository
  namespace        = var.namespace

  # Iterate over helm_set_values
  dynamic "set" {
    for_each = var.list_set
    content {
      name  = set.value.name
      value = set.value.value
    }
  }

}
