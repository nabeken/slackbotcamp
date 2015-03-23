provider "digitalocean" {
  token = "${var.do_token}"
}

# placeholder for domain
resource "digitalocean_domain" "default" {
  name = "${var.do_domain}"
  ip_address = "${digitalocean_droplet.slackbotcamp.ipv4_address}"
}

resource "digitalocean_record" "slackbotcamp" {
  domain = "${var.do_domain}"
  type = "A"
  name = "slackbotcamp"
  value = "${digitalocean_droplet.slackbotcamp.ipv4_address}"
}

resource "digitalocean_droplet" "slackbotcamp" {
  image = "ubuntu-14-04-x64"
  name = "slackbotcamp1"
  region = "${var.do_region}"
  size = "512mb"
  ssh_keys = ["${var.do_ssh_key}"]
}
