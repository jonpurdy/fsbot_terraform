variable "subdomain" {
    type    = string
    default = "tf"
}

variable "region" {
    type    = string
    default = "sfo2"
}

variable "node_count" {
    type    = number
    default = 1
}

variable "chainlink_directory" {
    type    = string
    default = "/root/.chainlink-ropsten"
}

variable "trex_wallet_private_key" {}

variable "elk_wallet_private_key" {}