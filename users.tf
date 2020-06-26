resource "google_service_account" "github" {
  account_id   = "github"
  display_name = "Github Service Account"
}

resource "google_service_account_key" "github" {
  service_account_id = google_service_account.github.name
}

resource "google_project_iam_member" "gke-dev" {
  role   = "roles/container.developer"
  member = "serviceAccount:${google_service_account.github.email}"
}

output "keys" {
    value = {
        "github": google_service_account_key.github.private_key
    }
    sensitive = true
}