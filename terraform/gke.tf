resource "google_container_cluster" "primary" {
  depends_on = [google_project_service.api]
  name     = "gke-cluster"
  location = var.zone

  networking_mode     = "VPC_NATIVE"
  remove_default_node_pool = true
  initial_node_count = 1
  network    = google_compute_network.gke_vpc.self_link
  subnetwork = google_compute_subnetwork.gke_subnet.self_link

  ip_allocation_policy {
    cluster_secondary_range_name  = "pods"
    services_secondary_range_name = "services"
  }

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = "172.16.0.0/28"
  }

  release_channel {
    channel = "REGULAR"
  }

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }

  enable_shielded_nodes = true
}

resource "google_container_node_pool" "primary_nodes" {
  depends_on = [google_project_service.api]

  name       = "primary-pool"
  cluster    = google_container_cluster.primary.name
  location   = var.zone
  node_count = 1

  node_config {
    machine_type = "e2-medium"
    disk_type = "pd-standard"
    disk_size_gb = 30
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
    labels = {
      workload = "general"
    }
    tags = ["gke-node"]
    shielded_instance_config {
      enable_secure_boot          = true
      enable_integrity_monitoring = true
    }
  }

  management {
    auto_upgrade = true
    auto_repair  = true
  }
}
