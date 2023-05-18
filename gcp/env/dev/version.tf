terraform {
  required_version = ">=0.13"

  required_providers {
    google = {
      source = "hashicorp/google"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.10"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.0.1"
    }
  }
  provider_meta "google" {
    module_name = "blueprints/terraform/terraform-google-kubernetes-engine:private-cluster/v25.0.0"
  }
}