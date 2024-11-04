
provider "aws" {
  region = "${var.region}"
  profile = "${var.aws_profile}"
}

module "network" {
  source = "github.com/nexomis/tf_tk//modules/network?ref=v1.0.10"
  cidr = "10.0.0.0/16"
  name = "${var.prefix}-single_ec2"
  public_subnets  = ["10.0.0.0/24"]
  private_subnets = ["10.0.1.0/24"]
  security_groups = [
    {
      name        = "${var.prefix}-sg_compute"
      description = "Security group for SSH serverapply"
      open_ports  = [22]
    }
  ]
}

module "compute_ec2" {
  source = "github.com/nexomis/tf_tk//modules/single_ec2?ref=v1.0.15"
  instance_ami = "ami-0cdfcb9783eb43c45"
  instance_type = "${var.instance_type}"
  volume_size = var.volume_size
  volume_iops = 8000
  volume_throughput = 1000
  name  = "${var.prefix}-compute"
  subnet_id = module.network.public_subnet_ids[0]
  security_group_id = module.network.security_group_ids["${var.prefix}-sg_compute"]
  associate_public_ip = true
  spot_instance = false
}

/*
module "block_volume" {
  source = "github.com/nexomis/tf_tk//modules/ebs_attached?ref=v1.0.12"
  type = "gp3"
  name_suffix = "${var.prefix}-attached-volume"
  size = var.volume_size_attached
  availability_zone = module.compute_ec2.availability_zone
  instance_id = module.compute_ec2.instance_id
  dev = "/dev/sdh"
  retain_count = 0
}
*/

module "ansible_project" {
  source        = "github.com/nexomis/tf_tk//modules/ansible_project?ref=v1.0.12"
  hosts = [
    {
      host_ip        = module.compute_ec2.instance_public_ip
      inventory_name = "compute"
      ansible_user   = "admin"
      pem_string     = module.compute_ec2.private_key_pem
    }
  ]
  ansible_dir = "./ansible"
}
