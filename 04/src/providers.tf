terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  backend "s3" {
    endpoint="storage.yandexcloud.net"
    bucket = "tfstate-developer"
    region = "ru-central1"
    key = "terraform.tfstate"

    skip_region_validation = true
    skip_credentials_validation = true

    dynamodb_endpoint = "https://docapi.serverless.yandexcloud.net/ru-central1/b1gjmftgjegm4ag26bp3/etnqkmb3bcvegntd$    dynamodb_table = "tfstate-lock"

  }
  required_version = ">=0.13"
}

provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.default_zone
}
