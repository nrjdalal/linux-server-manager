_ONLYSUDO

curl -fsSL https://nginx.org/keys/nginx_signing.key | gpg --dearmor -o /usr/share/keyrings/nginx_signing.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/nginx_signing.gpg] http://nginx.org/packages/ubuntu $(lsb_release -cs) nginx" | tee /etc/apt/sources.list.d/nginx.list
apt update
apt install nginx -y

mkdir -p /etc/nginx/{sites-available,sites-enabled}
if ! grep -q "include /etc/nginx/sites-enabled/\*;" /etc/nginx/nginx.conf; then
  sed -i 's#    include /etc/nginx/conf.d/\*.conf;#    include /etc/nginx/conf.d/\*.conf;\n    include /etc/nginx/sites-enabled/\*.conf;#' /etc/nginx/nginx.conf
fi

systemctl enable --now nginx
nginx -t && nginx -s reload
