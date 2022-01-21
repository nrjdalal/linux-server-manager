url="$LIB_URL/install"

case ${data[1]} in
certbot) src "$url/certbot.sh" ;;
nginx) src "$url/nginx.sh" ;;
node | nodejs) src "$url/node.sh" ;;
esac
