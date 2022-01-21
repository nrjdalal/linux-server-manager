read -p "Enter domain name ~ " DOMAIN

certbot certonly --nginx --agree-tos --no-eff-email --register-unsafely-without-email --cert-name $DOMAIN -d $DOMAIN,www.$DOMAIN
