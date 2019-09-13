provider "aws" {
  region = "${var.region}"
}

# Configure the Netlify Provider
provider "netlify" {
  token    = "${var.netlify_token}"
}

# Create a new deploy key for this specific website
resource "netlify_deploy_key" "key" {}

# Define your site
resource "netlify_site" "main" {
  name = "klebinho-site"

  repo {
    repo_branch   = "master"
    command       = "npm run build"
    deploy_key_id = "${netlify_deploy_key.key.id}"
    dir           = "build"
    provider      = "github"
    repo_path     = "mjunior/react-terraform-ci"
  }
}