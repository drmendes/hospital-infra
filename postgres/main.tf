# Persistent Volume Claim for PostgreSQL
resource "kubernetes_persistent_volume_claim" "postgres_pvc" {
  metadata {
    name = "postgres-pvc"
  }
  spec {
    access_modes = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "1Gi"
      }
    }
  }
}

# Kubernetes Deployment for PostgreSQL
resource "kubernetes_deployment" "postgres" {
  metadata {
    name = "postgresql"
    labels = {
      app = "postgresql"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "postgresql"
      }
    }

    template {
      metadata {
        labels = {
          app = "postgresql"
        }
      }

      spec {
        container {
          name  = "postgres"
          image = "postgres:13"

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
            name = "POSTGRES_USER"
            value_from {
              secret_key_ref {
                name = "postgresql-credentials"
                key  = "username"
              }
            }
          }
          env {
            name = "POSTGRES_PASSWORD"
            value_from {
              secret_key_ref {
                name = "postgresql-credentials"
                key  = "password"
              }
            }
          }

          volume_mount {
            mount_path = "/var/lib/postgresql/data"
            name      = "postgres-storage"
          }
        }

        volume {
          name = "postgres-storage"

          persistent_volume_claim {
            claim_name = kubernetes_persistent_volume_claim.postgres_pvc.metadata[0].name
          }
        }
      }
    }
  }
}

# Kubernetes Service for PostgreSQL
resource "kubernetes_service" "postgres_service" {
  metadata {
    name = "postgresql"
  }
  spec {
    selector = {
      app = "postgresql"
    }
    port {
      port        = 5432
    }

    type = "ClusterIP"
  }
}


resource "kubernetes_secret" "postgresql_credentials" {
  metadata {
    name      = "postgresql-credentials"
    namespace = "default"
  }

  data = {
    username = base64encode(var.postgres_username)
    password = base64encode(var.postgres_password)
  }
}
