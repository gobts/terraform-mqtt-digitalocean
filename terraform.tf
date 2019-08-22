provider "digitalocean" {
}

data "digitalocean_ssh_key" "default" {
  name = "${var.ssh_key_name}"
}

data "template_file" "user_data" {
  template = "${file("${path.module}/user-data.sh")}"

  vars = {
		domain = "${var.domain_name}"
		user = "${var.user}"
		email = "${var.email}"
		password = "${var.password}"
  }
}

resource "digitalocean_droplet" "mosquitto" {
  name   = "${var.digitalocean_droplet_name}"
  image  = "${var.digitalocean_droplet_image}"
  size   = "${var.digitalocean_droplet_size}"
  region = "${var.digitalocean_droplet_region}"
  ssh_keys = ["${data.digitalocean_ssh_key.default.id}"]
	user_data = "${data.template_file.user_data.rendered}"
}
