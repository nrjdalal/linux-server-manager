#!/bin/bash
set -e

data=("$@")
source /usr/lib/vero/utils.sh

url="$LIB_URL"

case ${data[0]} in
certbot)
  src "$url/certbot.sh"
  ;;
init | update | upgrade | autoremove)
  src "$url/init.sh"
  ;;
i | install)
  src "$url/install.sh"
  ;;
nginx)
  src "$url/nginx.sh"
  ;;
--update | --upgrade)
  sudo /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/nrjdalal/linux-server-manager/master/install.sh)"
  ;;
esac
_SUCCESS
