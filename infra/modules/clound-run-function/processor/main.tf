resource "google_cloudfunctions2_function" "processor_function" {
  location = "europe-west1"
  name     = "processor-function"
  
  build_config {
    runtime = "dotnet8"
    entry_point = "InstMarketingProcessor.Analyzer.Function"
    
    source {
      storage_source {
        bucket = "processor-function"
        object = "InstMarketingProcessor.Analyzer.zip"
      }
    }
  }
  
  service_config {
    max_instance_request_concurrency = 1
    available_memory = "256Mi"
    min_instance_count = 0
    ingress_settings = "ALLOW_ALL"
    all_traffic_on_latest_revision = true
    max_instance_count = 1
  }
}

data "google_iam_policy" "noauth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

resource "google_cloud_run_service_iam_policy" "no_auth" {
  location    = "europe-west1"
  service     = google_cloudfunctions2_function.processor_function.name

  policy_data = data.google_iam_policy.noauth.policy_data
}