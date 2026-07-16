# MariaDB

Installer le [paquet logiciel](package.md) `mariadb-server`.

```sh
apt install --no-install-recommends mariadb-server
```

## Docker

```shell
docker pull mariadb:12.0
```

```shell
docker network create mariadb_net
```

```shell
docker run --detach --name mariadb \
  -e MARIADB_ROOT_PASSWORD=my-secret-pw \
  --network mariadb_net \
  -p 3306:3306 \
  -v "mariadb_data:/var/lib/mysql" \
  mariadb:12.0
```

## phpMyAdmin

```shell
docker pull phpmyadmin:5.2-apache
```

```shell
docker run --detach --name phpmyadmin \
  -e "PMA_HOST=mariadb" \
  --network mariadb_net \
  --network proxy_net \
  --label "caddy=phpmyadmin.localhost" \
  --label "caddy.reverse_proxy={{upstreams 80}}" \
  --label "caddy.tls=internal" \
  phpmyadmin:5.2-apache
```
