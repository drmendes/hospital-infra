provider "google" {

  credentials = var.GCP_SA_KEY
  project     = var.project_id
  region      = var.region
}

module "gke" {
  source = "./gke"
}

module "challenge-app" {
  source = "./challenge-app"
}

module "postgres" {
  source = "./postgres"
  
  postgres_username = var.postgres_username
  postgres_password = var.postgres_password
}

