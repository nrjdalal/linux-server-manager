_ONLYSUDO

echo 'Existing configs ~'
ls /etc/nginx/sites-enabled/

read -p "Enter domain name ~ " DOMAIN
read -p "Enter proxy :port ~ " PORT

rm -rf /etc/nginx/sites-available/$DOMAIN.* /etc/nginx/sites-enabled/$DOMAIN.*

nginx -s reload

cat >/etc/nginx/sites-available/$DOMAIN.$PORT.conf <<CONF
server {
  server_name $DOMAIN www.$DOMAIN;

  listen 80;
  listen [::]:80;

  return 301 https://\$host\$request_uri;
}
CONF

cat >/etc/nginx/sites-available/$DOMAIN.ssl.$PORT.conf <<CONF
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

ln -s /etc/nginx/sites-available/$DOMAIN.$PORT.conf /etc/nginx/sites-enabled/$DOMAIN.$PORT.conf 2>/dev/null || true
ln -s /etc/nginx/sites-available/$DOMAIN.ssl.$PORT.conf /etc/nginx/sites-enabled/$DOMAIN.ssl.$PORT.conf 2>/dev/null || true

nginx -s reload

echo
echo "Config 80 created. Verify by ~ $(tput setaf 3)cat /etc/nginx/sites-enabled/$DOMAIN.$PORT.conf$(tput sgr0)"
echo "Config 443 created. Verify by ~ $(tput setaf 3)cat /etc/nginx/sites-enabled/$DOMAIN.ssl.$PORT.conf$(tput sgr0)"
