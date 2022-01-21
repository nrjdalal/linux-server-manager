_ONLYSUDO

read -p "Enter domain name ~ " DOMAIN
echo
echo "Ports in use: "${BOLD}${magenta}$(grep -Eho "127.0.0.1:.{4}" /etc/nginx/sites-available/*.conf | awk '{print substr($0,length($0)-3)}')${OFF} 2>/dev/null
echo
ls /etc/nginx/sites-enabled/
read -p "Enter proxy :port ~ " PORT

rm -rf /etc/nginx/sites-available/$PORT.$DOMAIN.80.conf /etc/nginx/sites-enabled/$PORT.$DOMAIN.80.conf
rm -rf /etc/nginx/sites-available/$PORT.$DOMAIN.443.conf /etc/nginx/sites-enabled/$PORT.$DOMAIN.443.conf

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
