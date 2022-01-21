url="$LIB_URL/nginx"

case ${data[1]} in
proxy-http) src "$url/proxy-80.sh" ;;
proxy | proxy-80 | proxy-443) src "$url/proxy-443.sh" ;;
root-80) src "$url/root-80.sh" ;;
root-443) src "$url/root-443.sh" ;;
esac
