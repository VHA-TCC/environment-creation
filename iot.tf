
resource "google_pubsub_topic" "topic" {
  name = var.pubsub_topic_name
  project = var.project_id
}

resource "google_pubsub_subscription" "subscription" {
  name = var.pubsub_subscription_name
  topic = google_pubsub_topic.topic.name
  project = google_pubsub_topic.topic.project
}

resource "google_cloudiot_registry" "registry" {
    name = var.iot_registry_name
    project = var.project_id
    region = var.region
    log_level = "INFO"

    event_notification_configs {
        pubsub_topic_name = google_pubsub_topic.topic.id
    }

    mqtt_config = {
        mqtt_enabled_state = "MQTT_ENABLED"
    }
}

resource "google_cloudiot_device" "device" {
    name = var.iot_device_name
    registry = google_cloudiot_registry.registry.id
    credentials {
        public_key {
            format = "RSA_X509_PEM"
            key = file("${var.iot_device_credential_path}")
        }
    }
}

output "pubsub_topic_name" {
    description = "Pubsub topic name: "
    value = google_pubsub_topic.topic.name
}

output "pubsub_subscription_name" {
    description = "Pubsub subscription name: "
    value = google_pubsub_subscription.subscription.name
}

output "cloud_iot_registry_name" {
    description = "Cloud IoT registry name: "
    value = google_cloudiot_registry.registry.name
}

output "cloud_iot_device_name" {
    description = "Cloud IoT device name: "
    value = google_cloudiot_device.device.name
}