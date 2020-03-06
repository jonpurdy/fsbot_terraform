# Futureswap bots Terraform

## Prerequisites

**Terraform**
- Install Terraform for your platform ([instructions](https://learn.hashicorp.com/terraform/getting-started/install.html))

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

Run:
```bash
terraform apply -auto-approve
```

## Tyrannosaurus Rekt (Liquidation Bot)

After Terraform is done spinning everything up, SSH into your VPS and run this to view the logs:
```bash
cd liquidation_bot/
docker-compose logs --follow --tail 100 api
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