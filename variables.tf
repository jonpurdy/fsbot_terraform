variable "subdomain" {
    type    = string
    default = "tf"
}

variable "region" {
    type    = string
    default = "sfo2"
}

variable "size" {
    type    = string
    default = "s-1vcpu-1gb"
}

variable "node_count" {
    type    = number
    default = 1
}

variable "trex_wallet_private_key" {}

variable "elk_wallet_private_key" {}