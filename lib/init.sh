_ONLYSUDO

apt update
apt upgrade -y

apt install snapd -y
snap install core
snap refresh core

apt install build-essential -y

apt autoremove -y

groupadd grwx || true
chgrp -R grwx /srv
chmod -R g+rwx /srv
