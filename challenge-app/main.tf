
# Kubernetes Deployment for the Challenge App
resource "kubernetes_deployment" "challenge_app" {
  metadata {
    name = "challenge-deployment"
    labels = {
      app = "challenge"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "challenge"
      }
    }

    template {
      metadata {
        labels = {
          app = "challenge"
        }
      }

      spec {
        container {
          name  = "challenge"
          image = "drmendes/challenge-app:${var.image_version}"
          resources {
            limits {
              cpu    = "500m"
              memory = "512Mi"
            }
            requests {
              cpu    = "250m"
              memory = "256Mi"
            }
          }

          env {
            name = "SPRING_DATASOURCE_URL"
            value = "jdbc:postgresql://postgresql:5432/postgres"
          }
          env {
            name = "SPRING_DATASOURCE_USERNAME"
            value_from {
              secret_key_ref {
                name = "postgresql-credentials"
                key  = "username"
              }
            }
          }
          env {
            name = "SPRING_DATASOURCE_PASSWORD"
            value_from {
              secret_key_ref {
                name = "postgresql-credentials"
                key  = "password"
              }
            }
          }
        }
      }
    }
  }
}

# Kubernetes Service for the Challenge App
resource "kubernetes_service" "challenge_service" {
  metadata {
    name = "challenge-service"
  }
  spec {
    selector = {
      app = "challenge"
    }
    port {
      port        = 8080
      target_port = 8080
    }

    type = "LoadBalancer"
  }
}
