
resource "google_container_cluster" "challenge_cluster" {
  name     = "challenge-cluster"
  location = "europe-west1"
  initial_node_count = 1

  master_auth {
    username = ""
    password = ""

    client_certificate_config {
      issue_client_certificate = false
    }
  }
}
