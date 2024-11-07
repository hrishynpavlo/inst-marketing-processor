resource "google_cloudbuildv2_repository" "inst_marketing_processor_repo" {
  location = "europe-west1"
  name = local.repo_name
  parent_connection = "inst-processor-gh-repo"
  remote_uri = var.repo_uri
}

data "google_service_account" "sa" {
  account_id = "terraform-sa@inst-marketing-processor-proj.iam.gserviceaccount.com"
}

resource "google_cloudbuild_trigger" "processor_trigger" {
  name = "processor-trigger-dev"
  location = "europe-west1"

  repository_event_config {
    repository = google_cloudbuildv2_repository.inst_marketing_processor_repo.id
    push {
      branch = "^develop$"
      invert_regex = false
    }
  }
  
  service_account = data.google_service_account.sa.id
  
  build {
    step {
      name = "ubuntu"
      entrypoint = "bash"
      args = ["-c", "apt-get update && apt-get install -y zip && zip -r function.zip /workspace/src/InstMarketingProcessor.Analyzer/*"]
      id = "Archive code"
    }
    
    step {
      name = "gcr.io/cloud-builders/gsutil"
      args = ["cp", "/workspace/function.zip", "gs://processor-function/InstMarketingProcessor.Analyzer.zip"]
      id = "Put archive to bucket"
    }
    
    step {
      name = "gcr.io/cloud-builders/gcloud"
      args = ["functions", "deploy", "processor-function", "--region=europe-west1", "--runtime=dotnet8", "--source=/workspace/function.zip", "--entry-point=InstMarketingProcessor.Analyzer.Function", "--trigger-http"]
      id = "Redeploy function"
    }
    
    options {
      logging = "CLOUD_LOGGING_ONLY"
    }
  }
}