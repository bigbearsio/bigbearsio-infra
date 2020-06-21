resource "google_container_cluster" "bigbears-cluster" {
    name = "bigbears-cluster"
    location = "asia-southeast1-b"

    node_pool {
        initial_node_count  = 3
        node_count          = 3
        node_locations      = ["asia-southeast1-b"]

        node_config {
            disk_size_gb      = 100
            disk_type         = "pd-standard"
            machine_type      = "n1-standard-1"
        }
    }
}

resource "google_compute_address" "traefik" {
  name = "traefik"
  region = "asia-southeast1"
}

locals {
    traefik = toset(["commerce", "commerce-api"])
}

resource "cloudflare_record" "traefik" {
  for_each = local.traefik

  zone_id = data.sops_file.secrets.data["cloudflare_bigbearsio_zone_id"]
  name    = each.value
  value   = google_compute_address.traefik.address
  type    = "A"
  ttl     = 3600
}