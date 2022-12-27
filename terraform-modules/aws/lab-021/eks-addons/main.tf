provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

resource "helm_release" "nginx_ingress_controller" {
  name             = "nginx-ingress-controller"
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  create_namespace = true
  namespace        = "ingress-controller"

  set {
    name  = "service.type"
    value = "LoadBalance"
  }
}

resource "helm_release" "k8s-dashboard" {
  name             = "k8s-dashboard"
  repository       = "https://kubernetes.github.io/dashboard"
  chart            = "kubernetes-dashboard"
  create_namespace = true
  namespace        = "k8s-dashboard"
  set {
    name  = "service.type"
    value = "ClusterIP"
  }

  values = [
    "${file("helm/kubernetes-dashboard/values.yaml")}"
  ]
}