variable "do_token" {}
variable "pub_key" {}
variable "pvt_key" {}
variable "ssh_fingerprint" {}

provider "digitalocean" {
  token = var.do_token
}

variable "cf_email" {}
variable "cf_api_key" {}
variable "cf_zone_id" {}

provider "cloudflare" {
  version = "~> 2.0"
  email   = var.cf_email
  api_key = var.cf_api_key
}