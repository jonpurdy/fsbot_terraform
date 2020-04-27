variable "subdomain" {
    type    = string
    default = "tf"
}

variable "region" {
    type    = string
    default = "sfo2"
}

variable "size-5" {
    type    = string
    default = "s-1vcpu-1gb"
}

variable "size-15" {
    type    = string
    default = "s-2vcpu-2gb"
}


variable "private_key_path" {
    type    = string
    default = "~/.ssh/id_rsa"
}

variable "network" {
    type    = string
    default = "testnet"
}

variable "trex_wallet_private_key" {}

variable "trex_wallet_private_key_1" {}

variable "elk_wallet_private_key" {}