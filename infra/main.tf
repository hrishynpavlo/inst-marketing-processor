##https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloudbuildv2_connection_iam




resource "google_cloudbuild_trigger" "github_analyzer_trigger" {
  name = "cloud-build-trigger-for-analyzer"
  
  github {
    
    owner = ""
    name = ""
    push {
      branch = "develop"
    }
  }
  
  build {
    step {
      name = "gcr.io/cloud-builders/gcloud"
      args = [
        "builds", "submit", "--tag", "gcr.io/$PROJECT_ID/analyzer-cloud-function", "."
      ]
    }
    step {
      name = "gcr.io/cloud-builders/gcloud"
      args = [
        "run", "deploy", "analyzer-cloud-function", "--image", "gcr.io/$PROJECT_ID/analyzer-cloud-function",
        "--platform", "managed", "--region", "europe-west1", "--allow-unauthenticated"
      ]
    }
    images = ["gcr.io/$PROJECT_ID/analyzer-cloud-function"]
  }
}

