resource "google_kms_key_ring" "bigbearsio" {
  name     = "bigbearsio"
  location = "global"
  depends_on = [
    google_project_service.cloudkms,
  ]
  lifecycle {
    prevent_destroy = true
  }
}

resource "google_kms_crypto_key" "sops-key" {
  name     = "sops-key"
  key_ring = google_kms_key_ring.bigbearsio.id
  purpose  = "ENCRYPT_DECRYPT"

  lifecycle {
    prevent_destroy = true
  }
}