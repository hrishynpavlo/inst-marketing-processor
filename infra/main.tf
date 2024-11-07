module "bucket" {
  source = "./modules/bucket"
}

module "cloud_build" {
  source = "./modules/cloud-build"
  repo_uri = var.repo_uri
}

module "processor_cloud_run_functions" {
  source = "./modules/clound-run-function/processor"
}