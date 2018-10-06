output "ipv4_address" {
  description = "the ipaddress of the mosquitto server"
  value = "${digitalocean_droplet.mosquitto.ipv4_address}"
}

