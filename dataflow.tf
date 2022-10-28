resource "google_storage_bucket" "dataflow_bucket" {
  name = "car-sensor-dataflow"
  location = var.region
  force_destroy = true
}

resource "google_bigquery_dataset" "dataflow_dataset" {
  dataset_id = "car_sensor_dataflow"
  friendly_name = var.bigquery_dataset_name
  location = var.bigquery_dataset_location
}

resource "google_storage_bucket_object" "dataflow_template" {
  name = var.dataflow_template.destination
  bucket = google_storage_bucket.dataflow_bucket.name
  source = var.dataflow_template.source
}

resource "google_bigquery_table" "dataflow_table" {
  dataset_id = google_bigquery_dataset.dataflow_dataset.dataset_id
  table_id = var.bigquery_table_name
  schema = <<EOF
  [
    {
      "name": "id",
      "type": "INTEGER",
      "mode": "NULLABLE",
      "description": "identifier"
    },
    {
      "name": "message",
      "type": "STRING",
      "mode": "NULLABLE",
      "description": "State where the head office is located"
    }
  ]
  EOF
}

# resource "google_dataflow_job" "job" {
#     name = "pubsub-to-bigquery-job-${timestamp()}"
#     project = var.project_id
#     region = var.region
#     zone = "${var.region}-a"
#     max_workers = 1
#     temp_gcs_location = "gs://${google_storage_bucket.dataflow_bucket.name}/temp"
#     template_gcs_path = "gs://${google_storage_bucket.dataflow_bucket.name}/${var.dataflow_template.destination}"
#     parameters = {
#         "bigquery_table_id" = "${var.project_id}:${var.bigquery_dataset_name}.${var.bigquery_table_name}"
#         "pubsub_topic_id" = "projects/${var.project_id}/topics/${var.pubsub_topic_name}"
#     }
# }