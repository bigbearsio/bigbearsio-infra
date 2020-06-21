resource "helm_release" "traefik" {
  name       = "traefik"
  repository = "https://containous.github.io/traefik-helm-chart" 
  chart      = "traefik"
  version    = "8.6.1"

  values = [file("helm/traefik-values.yaml")]

  set {
      name = "service.spec.loadBalancerIP"
      value = google_compute_address.traefik.address
  }

}