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

# Example: DNS records
# 
# resource "cloudflare_record" "k8" {
#   zone_id = data.sops_file.secrets.data["cloudflare_bigbearsio_zone_id"]
#   name    = "k8"
#   value   = google_container_cluster.bigbears-cluster.endpoint
#   type    = "A"
#   ttl     = 3600
# }