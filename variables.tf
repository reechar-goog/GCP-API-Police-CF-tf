variable "project_id" {
  description = "Project ID to hold GCF"
}

variable "org_id" {
  description = "Organization ID to monitor"
}

variable "billing_id" {
  description = "Billing Account ID to charge"
}

variable "pubsub_topic" {
  description = "Pub/Sub topic name to export logs to"
  default     = "service-activate-topic"
}

variable "export_sink" {
  description = "StackDriver log export sink"
  default     = "service-activate-sd-sink"
}
