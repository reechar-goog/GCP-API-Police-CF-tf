resource "google_pubsub_topic_iam_binding" "publisher" {
  project = "${google_project.api_police_project.project_id}"
  topic   = "${google_pubsub_topic.api_enable_topic.name}"
  role    = "roles/pubsub.publisher"
  members = ["${google_logging_organization_sink.api_sink.writer_identity}"]
}

resource "google_organization_iam_member" "binding" {
  org_id     = "${var.org_id}"
  role       = "roles/editor"
  member     = "serviceAccount:${google_project.api_police_project.project_id}@appspot.gserviceaccount.com"
  depends_on = ["google_cloudfunctions_function.function"]
}
