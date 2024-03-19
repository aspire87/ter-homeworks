module "vpc_dev" {
  source     = "./vpc_dev"
  zone       = var.default_zone
  cidr_block = ["10.0.1.0/24"]
  env_name   = "develop"
}

module "marketing-vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name       = "develop"
  network_id     = module.vpc_dev.vpc_network.id
  subnet_zones   = [var.default_zone]
  subnet_ids     = [module.vpc_dev.vpc_subnet.id]
  instance_name  = "web"
  instance_count = 1
  image_family   = var.image_family
  public_ip      = true
  labels = {
    project = "marketing"
  }
  metadata = {
    user-data          = data.template_file.cloudinit.rendered
    serial-port-enable = 1
  }
}

module "analytics-vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name       = "stage"
  network_id     = module.vpc_dev.vpc_network.id
  subnet_zones   = [var.default_zone]
  subnet_ids     = [module.vpc_dev.vpc_subnet.id]
  instance_name  = "web-stage"
  instance_count = 1
  image_family   = var.image_family
  public_ip      = true
  labels = {
    project = "analytics"
  }
  metadata = {
    user-data          = data.template_file.cloudinit.rendered
    serial-port-enable = 1
  }

}

data "template_file" "cloudinit" {
  template = file("./cloud-init.yml")
  vars = {
    public_key = local.ssh-keys
  }
}