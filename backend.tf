data "sops_file" "secrets" {
  source_file = "secrets.sops.json"
}


provider "google" {
  project     = "bigbears-io"
  region      = "asia-southeast1"
}

provider "google-beta" {
  project     = "bigbears-io"
  region      = "asia-southeast1"
}

provider "cloudflare" {
  version = "~> 2.0"
  api_token = data.sops_file.secrets.data["cloudflare_bigbearsio_api_token"]
}

provider "helm" {
  kubernetes {
    config_context = "gke_bigbears-io_asia-southeast1-b_bigbears-cluster"
  }
}

provider "kubernetes" {
  config_context = "gke_bigbears-io_asia-southeast1-b_bigbears-cluster"
}

terraform {
  backend "gcs" {
    bucket  = "bigbearsio-tfstate"
    prefix  = "bigbearsio-infra"
  }
}
