resource "google_project_service" "pubsub" {
  project = "${google_project.api_police_project.project_id}"
  service = "pubsub.googleapis.com"
}

resource "google_project_service" "servicemanagement" {
  project = "${google_project.api_police_project.project_id}"
  service = "servicemanagement.googleapis.com"
}

resource "google_project_service" "cloudfunctions" {
  project = "${google_project.api_police_project.project_id}"
  service = "cloudfunctions.googleapis.com"
}
