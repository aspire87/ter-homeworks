
terraform {
  required_version = ">=1.5"
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = ">=0.13"
    }
    template={
      source = "hashicorp/template"
      version = ">=2.1"
    }
  }
  backend "s3" {
    endpoint="storage.yandexcloud.net"
    bucket = "tfstate-developer"
    region = "ru-central1"
    key = "terraform.tfstate"

    skip_region_validation = true
    skip_credentials_validation = true

    dynamodb_endpoint = "https://docapi.serverless.yandexcloud.net/ru-central1/b1gjmftgjegm4ag26bp3/etnqkmb3bcvegntd1pls"
    dynamodb_table = "tfstate-lock"
  }
}

provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.default_zone
}