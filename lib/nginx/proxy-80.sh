_ONLYSUDO

echo 'Existing configs ~'
ls /etc/nginx/sites-enabled/

read -p "Enter domain name ~ " DOMAIN
read -p "Enter proxy :port ~ " PORT

rm -rf /etc/nginx/sites-available/*.$DOMAIN.80.conf /etc/nginx/sites-enabled/*.$DOMAIN.80.conf
rm -rf /etc/nginx/sites-available/*.$DOMAIN.443.conf /etc/nginx/sites-enabled/*.$DOMAIN.443.conf

nginx -s reload

cat >/etc/nginx/sites-available/$PORT.$DOMAIN.80.conf <<CONF
server {
  server_name $DOMAIN www.$DOMAIN;

  listen 80;
  listen [::]:80;

  location / {
    proxy_pass http://127.0.0.1:$PORT;
  }
}
CONF

ln -s /etc/nginx/sites-available/$PORT.$DOMAIN.80.conf /etc/nginx/sites-enabled/$PORT.$DOMAIN.80.conf 2>/dev/null || true

nginx -s reload

echo
echo "Config created. Verify by ~ $(tput setaf 3)cat /etc/nginx/sites-enabled/$PORT.$DOMAIN.80.conf$(tput sgr0)"
