# vero linux-server-manager
```bash
sudo /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/nrjdalal/linux-server-manager/master/install.sh)"
```

# Initial run

```bash
vero init && vero i nginx && vero i node && vero i certbot
```

# Serve a http domain via reverse proxy

```bash
vero nginx proxy-80
```

# Serve a https domain via reverse proxy

> Issue a certificate via Certbot first

```bash
vero certbot --nginx
vero nginx proxy-443
```
