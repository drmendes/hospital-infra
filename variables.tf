
variable "project_id" {
  description = "The ID of the project in which to provision resources."
  type        = string
}

variable "region" {
  description = "The region in which to provision resources."
  default     = "europe-west1"
}

variable "postgres_username" {
  description = "PostgreSQL Username"
  type        = string
}

variable "postgres_password" {
  description = "PostgreSQL Password"
  type        = string
}

variable "GCP_SA_KEY" {
  description = "The GCP Service Account Key"
  type        = string
  sensitive   = true
}

