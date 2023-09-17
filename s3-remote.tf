terraform {
  backend "s3" {
    bucket = "terraform-state-s3-blackteam2023"
    key    = "remote.tfstate"
    region = "us-west-1"
  }
}
