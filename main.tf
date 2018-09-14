resource "google_project" "api_police_project" {
  name                = "GCP API Police"
  project_id          = "${var.project_id}"
  org_id              = "${var.org_id}"
  billing_account     = "${var.billing_id}"
  auto_create_network = false
}

resource "google_pubsub_topic" "api_enable_topic" {
  name       = "${var.pubsub_topic}"
  project    = "${google_project.api_police_project.project_id}"
  depends_on = ["google_project_service.pubsub"]
}

resource "google_logging_organization_sink" "api_sink" {
  name             = "${var.export_sink}"
  org_id           = "${var.org_id}"
  include_children = true
  destination      = "pubsub.googleapis.com/projects/${google_project.api_police_project.project_id}/topics/${var.pubsub_topic}"
  filter           = "resource.labels.method=\"google.api.servicemanagement.v1.ServiceManager.EnableService\" OR resource.labels.method=\"google.api.servicemanagement.v1.ServiceManagerV1.ActivateServices\""
}

resource "google_cloudfunctions_function" "function" {
  project               = "${google_project.api_police_project.project_id}"
  region                = "us-central1"
  name                  = "apiPolice"
  source_archive_bucket = "reechar-utility"
  source_archive_object = "gcf.zip"
  trigger_topic         = "${google_pubsub_topic.api_enable_topic.name}"
  retry_on_failure      = true
  depends_on            = ["google_project_service.cloudfunctions", "google_project_service.servicemanagement"]
}
