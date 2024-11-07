module "bucket" {
  source = "./modules/bucket"
}

module "cloud_build" {
  source = "./modules/cloud-build"
  repo_uri = var.repo_uri
}