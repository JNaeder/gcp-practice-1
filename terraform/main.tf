terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.25.0"
    }
  }
}

provider "google" {
  project = "gcp-practice-1-453919"
  region  = "us-central1"
  zone    = "us-central1-c"
}

resource "google_compute_network" "mynetwork" {
  name                    = "mynetwork"
  auto_create_subnetworks = true
}

resource "google_compute_firewall" "web-rules" {
  name = "allow-web-traffic"
  network = google_compute_network.mynetwork.name
  source_ranges = ["0.0.0.0/0"]

  allow {
    protocol = "tcp"
    ports = ["80", "443"]
  }
}

resource "google_compute_firewall" "ssh-rules" {
  name = "allow-ssh"
  network = google_compute_network.mynetwork.name
  source_ranges = ["0.0.0.0/0"]

  allow {
    protocol = "tcp"
    ports = ["22"]
  }
}

resource "google_compute_instance" "web-server" {
  name         = "web-server"
  machine_type = "e2-micro"
  description  = "Server for my awesome website"

  boot_disk {
    initialize_params {
      image = "projects/ubuntu-os-cloud/global/images/ubuntu-2004-focal-v20250313"
      size  = 20
    }
  }

  network_interface {
    network = google_compute_network.mynetwork.name
    access_config {}
  }
}