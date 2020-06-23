locals {
    gke_endpoints = {
      "commerce": { "serviceName": "bigbears-commerce", "servicePort": 3000 }
    }
}

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

resource "google_compute_global_address" "gke_endpoints" {
  for_each = local.gke_endpoints

  name = each.key
}

resource "google_compute_managed_ssl_certificate" "gke_endpoints" {
  for_each = local.gke_endpoints 
  provider = google-beta

  name = each.key

  managed {
    domains = ["${each.key}.bigbears.io"]
  }
}

resource "cloudflare_record" "gke" {
  for_each = local.gke_endpoints

  zone_id = data.sops_file.secrets.data["cloudflare_bigbearsio_zone_id"]
  name    = each.key
  value   = google_compute_global_address.gke_endpoints[each.key].address
  type    = "A"
  ttl     = 3600
}