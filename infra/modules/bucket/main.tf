resource "google_storage_bucket" "statistic_bucket" {
  name = "inst-statistic"
  location = "EU"
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