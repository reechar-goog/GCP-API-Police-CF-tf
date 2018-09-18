resource "google_storage_bucket" "gcf_source_bucket" {
  name    = "${var.gcs_bucket}"
  project = "${google_project.api_police_project.project_id}"
}

resource "google_storage_bucket_object" "gcf_zip" {
  name   = "gcf.zip"
  bucket = "${google_storage_bucket.gcf_source_bucket.name}"
  source = "${var.gcf_zip}"
}
