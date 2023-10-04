provider "google" {
  credentials = file("<SA>")
  project     = var.project_id
  region      = var.region
}

module "gke" {
  source  = "./gke"
  project = var.project_id
  region  = var.region
}

module "postgres" {
  source  = "./postgres"
  project = var.project_id
  region  = var.region
}

module "challenge_app" {
  source  = "./challenge-app"
  cluster = module.gke.cluster_name

