url="$LIB_URL/certbot"

case ${data[1]} in
--nginx) src "$url/nginx.sh" ;;
esac
