resource "helm_release" "rabbitmq" {
  
  name       = "rabbitmq"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "rabbitmq"
  namespace  = var.namespace
  timeout    = 600
  create_namespace = true
  values = [
    templatefile("${path.module}/helm/values.yaml",{
        hostname                = "${var.rabbitmq_hostname}"
        namespace               = "${var.namespace}"
    })
  ]
}


data "kubernetes_secret" "rabbitmq-secret" {
  depends_on  = [resource.helm_release.rabbitmq]
  metadata {
    name      = "rabbitmq"
    namespace = var.namespace
  }
}

output "rabbitmq_password" {
  description = "password"
  value       = nonsensitive(data.kubernetes_secret.rabbitmq-secret.data.rabbitmq-password)
}