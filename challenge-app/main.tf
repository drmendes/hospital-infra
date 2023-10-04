resource "kubernetes_deployment" "challenge_app" {
  metadata {
    name = "challenge-app-deployment"
  }

  spec {
    replicas = 2

  }
}

