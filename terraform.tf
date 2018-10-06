variable "domain_name" {
  description = "the domain the MQTT server will create SSL keys for, example mqtt.mydomain.com"
}

variable "ssh_key_name" {
  description = "digital ocean ssh key to install on the droplet"
}

variable "email" {
  description = "the email to use for letsencrypt"
}

variable "user" {
  description = "the mqtt user to setup in MQTT"
}

variable "password" {
  description = "the mqtt password for the user to set up in MQTT"
}

provider "digitalocean" {
}

data "digitalocean_ssh_key" "default" {
  name = "${var.ssh_key_name}"
}

data "template_file" "user_data" {
  template = "${file("${path.module}/user-data.sh")}"

  vars {
		domain = "${var.domain_name}"
		user = "${var.user}"
		email = "${var.email}"
		password = "${var.password}"
  }
}

resource "digitalocean_droplet" "mosquitto" {
  image  = "ubuntu-18-04-x64"
  name   = "mosquitto"
  region = "lon1"
  size   = "s-1vcpu-1gb"
  ssh_keys = ["${data.digitalocean_ssh_key.default.id}"]
	user_data = "${data.template_file.user_data.rendered}"
}

output "mosquitto" {
  description = "the ipaddress of the mosquitto server"
  value = "${digitalocean_droplet.mosquitto.ipv4_address}"
}

