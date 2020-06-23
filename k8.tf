# resource "helm_release" "traefik" {
#   name       = "traefik"
#   repository = "https://containous.github.io/traefik-helm-chart" 
#   chart      = "traefik"
#   version    = "8.6.1"

#   values = [file("helm/traefik-values.yaml")]

#   set {
#       name = "service.spec.loadBalancerIP"
#       value = google_compute_address.traefik.address
#   }

# }

# GKE Ingress does not support HTTP redirect or disable, yet; https://github.com/kubernetes/ingress-gce/issues/1075
resource "kubernetes_ingress" "gke_endpoints" {
  for_each = local.gke_endpoints

  metadata {
    name = "${each.key}-ingress"

    annotations = {
      "ingress.gcp.kubernetes.io/pre-shared-cert"   = google_compute_managed_ssl_certificate.gke_endpoints[each.key].name
      "kubernetes.io/ingress.global-static-ip-name" = google_compute_global_address.gke_endpoints[each.key].name
    }
  }

  spec {
    rule {
      http {
        path {
          backend {
            service_name = each.value.serviceName
            service_port = each.value.servicePort
          }
        }
      }
    }
  }
}