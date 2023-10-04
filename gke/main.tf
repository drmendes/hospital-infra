data "google_container_cluster" "primary" {
  name     = "autopilot-cluster-1"
  location = var.region
}

output "endpoint" {
  value = data.google_container_cluster.primary.endpoint
}

