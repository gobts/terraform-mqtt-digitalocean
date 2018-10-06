# terraform-mqtt-digitalocean
A terraform module for creating a [mosquitto](https://mosquitto.org/) MQTT broker on digital ocean. 
The droplet will be accessible via the supplied ssh key. 
The broker will be secured by SSL using [letsencrypt](https://letsencrypt.org) and the supplied username and password.

# Usage 
Instructions for using terraform modules can be found within the [Terraform documentation](https://www.terraform.io/docs/modules/usage.html)
It is strongly recommended that when using this module, you use versioned links to the repository.

The following minimal terraform template example will create the cluster using the supplied variables.
```
module "mqtt" {
  source = "git::https://github.com/roylines/terraform-mqtt-digitalocean?ref=1.0.0"
  domain_name = "mqtt.mydomain.com"
  ssh_key_name = "myssh"
  email = "awesome@mydomain.com"
  user = "roy"
  password = "lines"
}
```

# Inputs
| Name | Description | Type | Default | Required |
| ------------- | ------------- | ------------- | ------------- | ------------- | 
| domain_name | the domain name for the broker | string | - | yes |
| ssh_key_name | digital ocean ssh key to install on the droplet | string| - | yes |
| email | the email to use for letsencrypt | string| - | yes |
| user | the user to setup in MQTT | string | - | yes |
| password | the password to setup in MQTT | string | - | yes |
| digitalocean_droplet_name | the name for the droplet | string | mosquitto | no |
| digitalocean_droplet_region | the region for the droplet | string | lon1 | no |
| digitalocean_droplet_image | the image for the droplet | string | ubuntu-18-04-x64 | no |
| digitalocean_droplet_size | the size of the droplet | string | s-1vcpu-1gb | no |

# Outputs
| Name | Description |
| ------------- | ------------- |
| ipv4_address | the ip address of the mosquitto server |
