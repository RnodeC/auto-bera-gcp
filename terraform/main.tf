terraform {
  backend "gcs" {
    bucket  = "auto-bera-tfbackend"
    prefix  = "terraform/state"
  }

  required_version = ">= 1.4.4"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.0"
    }
  }
}

provider "google" {
  project     = var.gcp_project
  region      = var.gcp_region
  zone        = "${var.gcp_region}-a"
  credentials = file(var.gcp_credentials_file)
}

resource "google_compute_network" "network" {
  name                    = "${var.name}-net"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  name          = "${var.name}-subnet"
  ip_cidr_range = var.subnet_cidr
  network       = google_compute_network.network.self_link
  region        = var.gcp_region
}

resource "google_compute_disk" "persistent_disk" {
  name   = "${var.name}-data"
  type   = var.data_disk_type
  size   = var.data_disk_size
  labels = var.labels
}

resource "google_compute_address" "public_ip" {
  name = "${var.name}-pip"
}

resource "google_compute_firewall" "firewall" {
  name    = "allow-bera-p2p"
  network = google_compute_network.network.self_link

  allow {
    protocol = "tcp"
    ports    = ["26656", "22"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_instance" "instance" {
  name         = "${var.name}-vm"
  machine_type = var.machine_type
  labels       = var.labels


  boot_disk {
    initialize_params {
      image = var.boot_disk_image
    }
  }

  attached_disk {
    source = google_compute_disk.persistent_disk.id
  }

  network_interface {
    network    = google_compute_network.network.self_link
    subnetwork = google_compute_subnetwork.subnet.self_link
    access_config {
      nat_ip = google_compute_address.public_ip.address
    }
  }

  metadata = {
    enable-oslogin = "TRUE"
  }

}
