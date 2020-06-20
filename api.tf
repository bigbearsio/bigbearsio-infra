# Has to create these in specific order
resource "google_project_service" "cloudresourcemanager" {
  service = "cloudresourcemanager.googleapis.com"
}

resource "google_project_service" "cloudkms" {
  service = "cloudkms.googleapis.com"
  depends_on = [ google_project_service.cloudresourcemanager ]
}