resource "google_compute_network" "gke_vpc" {
  name                    = var.network_name
  auto_create_subnetworks = false

  depends_on = [google_project_service.api]
}

resource "google_compute_subnetwork" "gke_subnet" {
  name          = var.subnet_name
  ip_cidr_range = "10.10.0.0/16"
  region        = var.region
  network       = google_compute_network.gke_vpc.id
  secondary_ip_range {
    range_name    = "pods"
    ip_cidr_range = "10.20.0.0/16"
  }
  secondary_ip_range {
    range_name    = "services"
    ip_cidr_range = "10.30.0.0/20"
  }

  depends_on = [google_project_service.api]
}

