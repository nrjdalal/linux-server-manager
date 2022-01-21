_ONLYSUDO

echo 'Existing configs ~'
ls /etc/nginx/sites-enabled/

read -p "Enter domain name ~ " DOMAIN
read -p "Enter proxy :port ~ " PORT

rm -rf /etc/nginx/sites-available/$PORT.$DOMAIN.80.conf /etc/nginx/sites-enabled/$PORT.$DOMAIN.80.conf
rm -rf /etc/nginx/sites-available/$PORT.$DOMAIN.443.conf /etc/nginx/sites-enabled/$PORT.$DOMAIN.443.conf

nginx -s reload

cat >/etc/nginx/sites-available/$PORT.$DOMAIN.80.conf <<CONF
server {
  server_name $DOMAIN www.$DOMAIN;

  listen 80;
  listen [::]:80;

  return 301 https://\$host\$request_uri;
}
CONF

cat >/etc/nginx/sites-available/$PORT.$DOMAIN.443.conf <<CONF
server {
  server_name $DOMAIN www.$DOMAIN;

  listen 443 ssl http2;
  listen [::]:443 ssl http2;

  ssl_certificate /etc/letsencrypt/live/$DOMAIN/fullchain.pem;
  ssl_certificate_key /etc/letsencrypt/live/$DOMAIN/privkey.pem;
  include /etc/letsencrypt/options-ssl-nginx.conf;
  ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem;

  location / {
    proxy_pass http://127.0.0.1:$PORT;
  }
}
CONF

ln -s /etc/nginx/sites-available/$PORT.$DOMAIN.80.conf /etc/nginx/sites-enabled/$PORT.$DOMAIN.80.conf 2>/dev/null || true
ln -s /etc/nginx/sites-available/$PORT.$DOMAIN.443.conf /etc/nginx/sites-enabled/$PORT.$DOMAIN.443.conf 2>/dev/null || true

nginx -s reload

echo
echo "Config 80 created. Verify by ~ $(tput setaf 3)cat /etc/nginx/sites-enabled/$PORT.$DOMAIN.80.conf$(tput sgr0)"
echo "Config 443 created. Verify by ~ $(tput setaf 3)cat /etc/nginx/sites-enabled/$PORT.$DOMAIN.443.conf$(tput sgr0)"
