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

# Certbot issue certificate

```bash
vero certbot --nginx
```

# Serve a https domain via reverse proxy

> It is recommended to issue a certificate via Certbot first

```bash
vero nginx proxy-443
```
