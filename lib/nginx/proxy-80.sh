_ONLYSUDO

tput setaf 5
ls /etc/nginx/sites-enabled/ | cat
tput sgr0

read -p "Enter domain name ~ " DOMAIN
read -p "Enter proxy :port ~ " PORT

rm -rf /etc/nginx/sites-available/$DOMAIN.* /etc/nginx/sites-enabled/$DOMAIN.*
nginx -s reload

cat >/etc/nginx/sites-available/$DOMAIN.$PORT.conf <<CONF
server {
  server_name $DOMAIN www.$DOMAIN;

  listen 80;
  listen [::]:80;

  location / {
    proxy_pass http://127.0.0.1:$PORT;
  }
}
CONF

ln -s /etc/nginx/sites-available/$DOMAIN.$PORT.conf /etc/nginx/sites-enabled/$DOMAIN.$PORT.conf 2>/dev/null || true

nginx -s reload

echo
echo "Config created. Verify by ~ $(tput setaf 3)cat /etc/nginx/sites-enabled/$DOMAIN.$PORT.conf$(tput sgr0)"
