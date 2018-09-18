/**
 * Copyright 2018 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
resource "google_storage_bucket" "gcf_source_bucket" {
  name    = "${var.gcs_bucket}"
  project = "${google_project.api_police_project.project_id}"
}

resource "google_storage_bucket_object" "gcf_zip" {
  name   = "gcf.zip"
  bucket = "${google_storage_bucket.gcf_source_bucket.name}"
  source = "${var.gcf_zip}"
}
