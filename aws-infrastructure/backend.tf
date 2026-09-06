terraform {
  backend "s3" {
    bucket       = "terraform-state-bucket-00125"
    key          = "url-shortener/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}