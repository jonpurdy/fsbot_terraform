# Futureswap bots Terraform

This repo allows you to deploy the Futureswap bots to DigitalOcean VPSs via Terraform.

There are two bots (so far):
[Tyrannosaurus Rekt (Liquidation Bot)](https://github.com/futureswap/liquidation_bot)
[ELK (Internal Exchange Bot)](https://github.com/futureswap/internal_exchange_bot)

As more bots get created, I will add support for them here.

Each bot is deployed to it's own VPS (default size is s-1vcpu-1gb, the cheap $5/mo or $0.07/hour one). Can be changed in variables.tf for larger instances.

CloudFlare is optional. It's used to assign a subdomain to the droplets so you can access them more easily. It's commented out by default.

## Diagram

```
 fs-trex0.yourdomain.com       fs-elk0.yourdomain.com
             |                            |
             |                            |
             v                            v
     +---------------+            +---------------+
     | fs-trex0 VPS  |            | fs-elk0 VPS   |
     | +-----------+ |            | +-----------+ |
     | | trex bot  | |            | | elk bot   | |
     | +-----------+ |            | +-----------+ |
     +---------------+            +---------------+
```

## Prerequisites

**Terraform**
- Install Terraform for your platform ([instructions](https://learn.hashicorp.com/terraform/getting-started/install.html))
Quick steps for Ubuntu:
```
wget https://releases.hashicorp.com/terraform/0.12.23/terraform_0.12.23_linux_amd64.zip
unzip terraform_0.12.23_linux_amd64.zip
mv terraform /usr/local/bin/
chmod +x /usr/local/bin/terraform
terraform version # prints version to test out the command
```

**DigitalOcean**
- DigitalOcean account (Create one [here](https://cloud.digitalocean.com/registrations/new))
- DigitalOcean API key (with write access) ([create it here](https://cloud.digitalocean.com/account/api/tokens/new))
- SSH private/public keypair from your local machine (added to DigitalOcean account [here](https://cloud.digitalocean.com/account/security))
- SSH fingerprint (get it from [here](https://cloud.digitalocean.com/account/security))

**Cloudflare (optional)**
- Cloudflare account ([sign up for free here](https://dash.cloudflare.com/sign-up))
- Domain name (example.com)
- API key (get it in your Account settings)
- Zone ID (for your domain, so it can create subdomains (bot.example.com)) (find it in your account Dashboard)

## Setup

Clone this repo:
```
git clone https://github.com/jonpurdy/fsbot_terraform.git
cd fsbot_terraform
```

Create a new file in this repo called terraform.tfvars.
```bash
touch terraform.tfvars
```

Edit it and add the the contents:
```
do_token = "YOUR_DO_TOKEN"
pub_key = "/.ssh/id_rsa.pub"
pvt_key = "~/.ssh/id_rsa"
ssh_fingerprint = "YOUR_SSH_FINGERPRINT"

# Uncomment if you want to assign a subdomain to your
# VPS through your CloudFlare Account
# cf_email = "YOUR_CLOUDFLARE_EMAIL"
# cf_api_key = "YOUR_CLOUDFLARE_API_KEY"
# cf_zone_id = "YOUR_CLOUDFLARE_ZONE_ID"

trex_wallet_private_key = "YOUR_TREX_WALLET_PRIVATE_KEY"
elk_wallet_private_key = "YOUR_ELK_WALLET_PRIVATE_KEY"
```

Run:
```bash
terraform apply -auto-approve
```

## Tyrannosaurus Rekt (Liquidation Bot)

After Terraform is done spinning everything up, SSH into your VPS and run this to view the logs:
```bash
cd liquidation_bot/
docker-compose logs --follow --tail 20 api
```

## ELK (Internal Exchange Bot)

After Terraform is done spinning everything up, SSH into your VPS and run this to view the logs:
```bash
cd internal_exchange_bot/
tail -f log.txt
```

## Destroy

When done testing, just run:
```bash
terraform destroy
```