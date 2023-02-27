#!/bin/sh

set -e

BASEDIR="/etc/letsencrypt"
DIGITALOCEAN_CREDIS="/certbot-creds.ini"

if [ -z "${DIGITALOCEAN_DOMAIN+1}" ]; then
    echo "Define DIGITALOCEAN_DOMAIN!" >&2
    exit 1
fi

if [ -z "${DIGITALOCEAN_DOMAIN_EMAIL+1}" ]; then
    echo "Define DIGITALOCEAN_DOMAIN_EMAIL!" >&2
    exit 1
fi

if ! [ -f "$DIGITALOCEAN_CREDIS" ]; then
    echo "Mount your credis to $DIGITALOCEAN_CREDIS" >&2
    exit 1
fi

if [ -d "$BASEDIR/live" ]; then
    certbot -q renew
else
    certbot certonly \
        --dns-digitalocean \
        --dns-digitalocean-credentials "$DIGITALOCEAN_CREDIS" \
        --dns-digitalocean-propagation-seconds 30 \
        --non-interactive \
        --agree-tos \
        -d "$DIGITALOCEAN_DOMAIN" \
        -m "$DIGITALOCEAN_DOMAIN_EMAIL"

    cd "$BASEDIR/live/$DIGITALOCEAN_DOMAIN"

    ln -s "fullchain.pem" "$DIGITALOCEAN_DOMAIN.crt"
    ln -s "privkey.pem"   "$DIGITALOCEAN_DOMAIN.key"
fi

exec crond -f -d 0
