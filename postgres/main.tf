resource "google_sql_database_instance" "default" {
  name             = "challenge-postgres"
  region           = var.region
  database_version = "POSTGRES_13"

}

