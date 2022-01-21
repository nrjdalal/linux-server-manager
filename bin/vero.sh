#!/bin/bash
set -e

data=("$@")
source /usr/lib/vero/utils.sh

url="$LIB_URL"

echo
case ${data[0]} in
certbot)
  src "$url/certbot.sh"
  ;;
init)
  src "$url/init.sh"
  ;;
i | install)
  src "$url/install.sh"
  ;;
nginx)
  src "$url/nginx.sh"
  ;;
-v | -version | --version)
  src "$url/version.sh"
  ;;
esac
echo
