resource "google_container_cluster" "primary" {
  name     = "challenge-cluster"
  location = var.region
}

output "endpoint" {
  value = google_container_cluster.primary.endpoint
}

