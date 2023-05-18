resource "kubernetes_namespace" "ingress_nginx" {
  metadata {
    name = "ingress-nginx"
  }
}

resource "helm_release" "ingress_nginx_controller" {
  depends_on = [kubernetes_namespace.ingress_nginx]

  name       = "ingress-nginx-controller"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  namespace  = "ingress-nginx"
  version    = var.ingress_nginx_version
  timeout    = 600

  values = [
    templatefile("${path.module}/values.yaml", {
      environment = "${var.environment}"
      name        = "${var.name}"
    })
  ]
}

data "kubernetes_service" "get_ingress_nginx_controller_svc" {
  depends_on = [helm_release.ingress_nginx_controller]

  metadata {
    name      = "ingress-nginx-controller-controller"
    namespace = "ingress-nginx"
  }
}

output "nginx_ingress_controller_dns_hostname" {
  description = "NGINX Ingress Controller DNS Hostname"
  value       = data.kubernetes_service.get_ingress_nginx_controller_svc.*.status.0.load_balancer.0.ingress.0.ip
}