resource "google_storage_bucket" "statistic_bucket" {
  name = "inst-statistic"
  location = "europe-west1"
  force_destroy = true
  
  lifecycle_rule {
    condition {
      age = 1
    }
    action {
      type = "Delete"
    }
  }
}

resource "google_storage_bucket" "processor_functions_bucket" {
  location = "europe-west1"
  name     = "processor-function"
  force_destroy = true
}