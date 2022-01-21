url="$LIB_URL/install"

case ${data[1]} in
brew | homebrew) src "$url/homebrew.sh" ;;
certbot) src "$url/certbot.sh" ;;
gh) src "$url/gh.sh" ;;
nginx) src "$url/nginx.sh" ;;
node | nodejs) src "$url/node.sh" ;;
esac
