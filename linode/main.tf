terraform {
  required_providers {
    linode = {
      source  = "linode/linode"
      version = "1.27.1"
    }
  }
}

provider "linode" {
  token = var.token
}




locals {
  retry_join = "provider=linode api_token=${var.token} region=${var.region} tag_name=auto-join address_type=public_v4"
}






resource "linode_instance" "server" {
  count = var.server_count
  type  = var.server_instance_type

  region = var.region
  image  = "linode/ubuntu20.04"

  root_pass = "linodePasswordDefault"

  tags = ["auto-join"]

  connection {
    type     = "ssh"
    user     = "root"
    password = "linodePasswordDefault"
    host     = self.ip_address
  }

  provisioner "remote-exec" {
    inline = ["sudo mkdir -p /ops", "sudo chmod 777 -R /ops"]
  }

  provisioner "file" {
    source      = "../shared"
    destination = "/ops"
  }

  provisioner "remote-exec" {
    inline = ["sudo chmod 777 -R /ops", 
    "export server_count=${var.server_count}",
    "export retry_join=${local.retry_join}", 
    "/ops/shared/data-scripts/user-data-server.sh"]
  }
}

resource "linode_instance" "client" {
  count = var.client_count
  type  = var.client_instance_type
  tags  = ["auto-join", "nomad-clients"]

  region = var.region
  image  = "linode/ubuntu20.04"


  root_pass = "linodePasswordDefault"

  connection {
    type     = "ssh"
    user     = "root"
    password = "linodePasswordDefault"
    host     = self.ip_address
  }

  provisioner "remote-exec" {
    inline = ["sudo mkdir -p /ops", "sudo chmod 777 -R /ops"]
  }

  provisioner "file" {
    source      = "../shared"
    destination = "/ops"
  }

  provisioner "remote-exec" {
    inline = ["sudo chmod 777 -R /ops",
    "export retry_join=${local.retry_join}", 
    "/ops/shared/data-scripts/user-data-server.sh"]
  }
  // Add any additional configuration here
}


variable "token" {}
variable "name" {}
variable "server_instance_type" {}
variable "server_count" {}
variable "region" {}
variable "client_instance_type" {}
variable "client_count" {}

