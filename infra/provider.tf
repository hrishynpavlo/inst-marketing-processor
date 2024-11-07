provider "google" {
  credentials = file(var.gcp_svc_key)
  project = "inst-marketing-processor-proj"
  region = "europe-west1"
}

