module "nginx_ingress_controller" {
  source                = "./addons/nginx-ingress-controller"
  count                 = var.ingress_nginx_enabled ? 1 : 0
  ingress_nginx_version = var.ingress_nginx_version
  environment           = var.environment
  name                  = var.name
}

module "cert_manager" {
  source               = "./addons/cert-manager"
  depends_on           = [module.nginx_ingress_controller]
  count                = var.cert_manager_enabled ? 1 : 0
  cert_manager_version = var.cert_manager_version
}

module "rabbitmq" {
  source            = "./k8s-services/rabbitmq"
  depends_on        = [module.cert_manager]
  count             = var.rabbitmq_enabled ? 1 : 0
  rabbitmq_hostname = var.rabbitmq_hostname
  namespace         = "default"

}