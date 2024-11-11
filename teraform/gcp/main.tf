# setting terraform
terraform {
    required_providers {
        google = {
            source = "hashicorp/google"
            version = "4.4.0"
        }
    }
}

provider "google" {
    project = "map-talk-432405"
    region = "asia-northeast1"
}

resource "google_service_account" "default" {
    account_id = "map-talk-432405-sa"
    display_name = "map-talk-service-account"
}

resource "google_compute_instance" "default" {
    name = "map-talk-instance"
    machine_type = "e2-micro"
    zone = "asia-northeast1-a"

    tags = ["map-talk"]

    boot_disk {
        initialize_params {
            image = "ubuntu-os-cloud/ubuntu-2204-jammy-v20240927"
        }
    }

    network_interface {
        network = "default"
        access_config {}
    }

    service_account {
        email = google_service_account.default.email
        scopes = ["cloud-platform"]
    }

    metadata_startup_script = file("startup.sh")
}