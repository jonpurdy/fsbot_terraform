#************ Tyrannosaurus Rekt (Liquidation Bot)************** #
#
resource "digitalocean_droplet" "fs-trex" {
    count = 1
    image = "ubuntu-18-04-x64"
    name = "fs-trex${count.index}"
    region = var.region
    size = var.size-5
    private_networking = true
    ssh_keys = [
      "${var.ssh_fingerprint}"
    ]

  connection {
      user = "root"
      type = "ssh"
      private_key = file(var.private_key_path)
      timeout = "2m"
      host = self.ipv4_address
  }

  provisioner "file" {
    source      = "extra/trex-nginx"
    destination = "/tmp/trex-nginx"
  }

  provisioner "remote-exec" {
    inline = [
      "export PATH=$PATH:/usr/bin",
      "apt update",
      "apt install -y git nginx goaccess",
      "cp /tmp/trex-nginx /etc/nginx/sites-available/trex",
      "ln -s /etc/nginx/sites-available/trex /etc/nginx/sites-enabled/trex",
      "rm /etc/nginx/sites-enabled/default",
      "mkdir /var/www/goaccess",
      "echo 'goaccess' > /var/www/goaccess/report.htm",
      "service nginx stop && service nginx start",
      "curl -sSL https://get.docker.com/ | sh",
      "curl -L 'https://github.com/docker/compose/releases/download/1.25.4/docker-compose-Linux-x86_64' -o /usr/local/bin/docker-compose",
      "chmod +x /usr/local/bin/docker-compose",
      "git clone https://github.com/futureswap/liquidation_bot.git",
      "echo 'PRIVATE_KEY=${var.trex_wallet_private_key}' > /root/liquidation_bot/.env",
      "cd liquidation_bot",
      "docker-compose up --detach"
    ]
    on_failure = continue
  }
}

#************ Ethereum Node ************** #
#
resource "digitalocean_droplet" "fs-eth" {
    count = 1
    image = "ubuntu-18-04-x64"
    name = "fs-eth${count.index}"
    region = var.region
    size = var.size-15
    private_networking = true
    ssh_keys = [
      "${var.ssh_fingerprint}"
    ]

  connection {
      user = "root"
      type = "ssh"
      private_key = file(var.private_key_path)
      timeout = "2m"
      host = self.ipv4_address
  }

  provisioner "remote-exec" {
    inline = [
      "export PATH=$PATH:/usr/bin",
      "apt install software-properties-common",
      "add-apt-repository -y ppa:ethereum/ethereum",
      "apt update",
      "apt install -y ethereum",
      "nohup geth --syncmode 'light' --${var.network} --rpc --rpcaddr '0.0.0.0' --rpcvhosts=* --ws --wsaddr 0.0.0.0 --wsorigins='*' 2> /var/log/geth.log &"
    ]
  }
}

# #************ ELK Rekt (Internal Exchange Bot)************** #
# #
# resource "digitalocean_droplet" "fs-elk" {
#     count = 0
#     image = "ubuntu-18-04-x64"
#     name = "fs-elk${count.index}"
#     region = var.region
#     size = "s-1vcpu-1gb"
#     ssh_keys = [
#       "${var.ssh_fingerprint}"
#     ]

#   connection {
#       user = "root"
#       type = "ssh"
#       private_key = "${file(var.pvt_key)}"
#       timeout = "2m"
#       host = self.ipv4_address
#   }

#   provisioner "remote-exec" {
#     inline = [
#       "export PATH=$PATH:/usr/bin",
#       "apt update",
#       "curl -sL https://deb.nodesource.com/setup_13.x | bash -",
#       "apt-get install -y nodejs",
#       "git clone https://github.com/futureswap/internal_exchange_bot.git",
#       "echo 'PRIVATE_KEY=${var.elk_wallet_private_key}' > /root/internal_exchange_bot/.env",
#       "cd internal_exchange_bot",
#       "npm install"
#     ]
#     on_failure = continue
#   }
# }

# T-Rex CF Domain
#
resource "cloudflare_record" "fs-trex" {
  count = 1
  zone_id = var.cf_zone_id
  name    = "fs-trex${count.index}"
  value   = digitalocean_droplet.fs-trex[count.index].ipv4_address
  type    = "A"
  ttl     = 1
}

# Ethereum CF Domain
#
resource "cloudflare_record" "fs-eth" {
  count = 1
  zone_id = var.cf_zone_id
  name    = "fs-eth${count.index}"
  value   = digitalocean_droplet.fs-eth[count.index].ipv4_address
  type    = "A"
  ttl     = 1
}

# # ELK CF Domain
# #
# resource "cloudflare_record" "fs-elk" {
#   count = 0
#   zone_id = var.cf_zone_id
#   name    = "fs-elk${count.index}"
#   value   = "${digitalocean_droplet.fs-elk[count.index].ipv4_address}"
#   type    = "A"
#   ttl     = 1
# }