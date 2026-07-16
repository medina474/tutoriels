# Apache

Installer le [paquet logiciel](package.md) apache

```shell
apt install --no-install-recommends apache2
```

> Fondamentalement, le serveur Apache n'exige pas seulement des autorisations de lecture de tous les fichiers qu'il dessert, mais l'autorisation d'exécution de tous les répertoires dans le chemin de votre hôte virtuel.

```shell
a2dismod autoindex
a2enmod rewrite
```

## PHP 8.4

```shell
apt install --no-install-recommends php-fpm

a2enconf php8.4-fpm
a2enmod proxy_fcgi
```

### Modules optionnels

#### Mbstring

```shell
apt install --no-install-recommends php-bcmath
```

```shell
apt install --no-install-recommends memcached libmemcached-tools
apt install --no-install-recommends php-memcached
apt install --no-install-recommends php-imagick
```

```shell
phpenmod imagick
```

```shell
apt list --installed | grep php
```

### Caddy

gpg: no valid OpenPGP data found
apt install ca-certificates

apt install --no-install-recommends debian-keyring apt-transport-https ca-certificates
apt install --no-install-recommends curl
apt install --no-install-recommends gpg

curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | tee /etc/apt/sources.list.d/caddy-stable.list
chmod o+r /usr/share/keyrings/caddy-stable-archive-keyring.gpg
chmod o+r /etc/apt/sources.list.d/caddy-stable.list
apt update
apt install caddy

a2enmod remoteip

### SMTP

```shell
apt install --no-install-recommends msmtp-mta
systemctl enable --now msmtpd
```

```shell
apachectl configtest
```
