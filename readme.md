## Setup

Create a file called terraform.tfvars with the contents:
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
tf apply -auto-approve
```

## Tyrannosaurus Rekt (Liquidation Bot)

After Terraform is done, SSH into your VPS and run:
```bash
cd liquidation_bot
docker-compose up
```

View logs:
`docker-compose logs --follow --tail 1000 api`


