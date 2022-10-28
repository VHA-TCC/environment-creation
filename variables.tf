variable "project_id" { 
    default = "tcc-obd-system"
    type = string
}

variable "region" {
    default = "us-central1"
    type = string
}

variable "google_credential_path" {
    default = "~/credentials/GCP/tcc-dev.json"
    type = string
}

variable "iot_registry_name" {
    default = "cloud-iot-car-sensor-registry"
    type = string
}

variable "iot_device_name" {
    default = "cloud-iot-car-sensor-device"
    type = string
}

variable "iot_device_credential_path" {
    default = "./certs/iot/rsa_cert.pem"
    type = string
}

variable "pubsub_topic_name" {
    default = "terraform-test-topic"
    type = string
}

variable "pubsub_subscription_name" {
    default = "terraform-test-subscription"
    type = string
}

variable "bigquery_dataset_location" {
    default = "US"
    type = string
}

variable "bigquery_dataset_name" {
    default = "car_sensor_dataflow"
    type = string
}

variable "bigquery_table_name" {
    default = "car_sensor_dataflow_table"
    type = string
}

variable "dataflow_template" {
    type = map(string)
    default = {
        source = "../dataflow-templates/pubsub_to_bigquery.json"
        destination = "templates/pubsub_to_bigquery.json"
    }
}