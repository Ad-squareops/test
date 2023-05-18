resource "kubernetes_namespace" "cert_manager" {
  metadata {
    name = "cert-manager"
  }
}

resource "null_resource" "jetstack" {
  depends_on = [kubernetes_namespace.cert_manager]
  provisioner "local-exec" {
    command = "kubectl apply --validate=false -f https://github.com/jetstack/cert-manager/releases/download/v${var.cert_manager_version}/cert-manager.crds.yaml"
  }
}

resource "helm_release" "cert_manager" {
  depends_on = [null_resource.jetstack]

  name       = "cert-manager"
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  namespace  = "cert-manager"
  version    = format("%s%s", "v", var.cert_manager_version)
  timeout    = 600

}

resource "null_resource" "cluster_issuer" {
  depends_on = [helm_release.cert_manager]
  provisioner "local-exec" {
    command = "kubectl apply -f ${path.module}/cluster-issuer.yaml"
  }
}