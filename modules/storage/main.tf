resource "google_storage_bucket" "fancy_store" {
  name          = "fancy-store-${var.project_id}"
  location      = "US"
  force_destroy = true
}

resource "google_storage_bucket_object" "startup_script" {
  name   = "startup-script.sh"
  bucket = google_storage_bucket.fancy_store.name
  source = "${path.module}/startup-script.sh"
  content_type = "text/plain"
}