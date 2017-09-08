#!/usr/bin/with-contenv bash

# generate new DH if necessary
NGINX_DH_SIZE=${NGINX_DH_SIZE:-2048}
if [[ -f /etc/nginx/keys/dh.pem ]]; then
    echo "============> Using existing DH file"
else
    echo "============> Generating dh.pem with size $NGINX_DH_SIZE"
    openssl dhparam -out /etc/nginx/keys/dh.pem "$NGINX_DH_SIZE"
fi

# generate new cert if necessary
if [[ -f /etc/nginx/keys/web.pem ]]; then
    echo "============> Using existing SSL keys"
else
    echo "============> Generating self-signed SSL keys"
    openssl req -newkey rsa:4096 -x509 -days 365 -nodes -sha256 \
        -subj "$NGINX_SSL_SUBJECT" \
        -keyout "/etc/nginx/keys/web.key" \
        -out "/etc/nginx/keys/web.crt" &>/dev/null
    cat /etc/nginx/keys/web.crt /etc/nginx/keys/web.key > /etc/nginx/keys/web.pem
fi

# fix permissions on SSL certificates
chmod 0400 /etc/nginx/keys/*
chmod 0644 /etc/nginx/keys/web.crt
