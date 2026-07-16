# Grafana

Grafana est un outil open source de **visualisation** et de **surveillance de données** principalement utilisé pour analyser et afficher des métriques de performance provenant de diverses sources. Il permet de créer des **tableaux de bord interactifs** et personnalisables pour surveiller des systèmes, des applications et des infrastructures. Grafana supporte de nombreux types de sources de données.

### Installer Grafana

```sh
wget -q -O - https://apt.grafana.com/gpg.key | gpg --dearmor | sudo tee /etc/apt/keyrings/grafana.gpg > /dev/null
echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com stable main" | tee -a /etc/apt/sources.list.d/grafana.list
apt update
apt install --no-install-recommends grafana-enterprise -y
```

Editer le fichier `/etc/grafana/grafana.ini`

```
[users]
allow_sign_up = false
allow_org_create = false
default_theme = system
default_language = fr-FR

[auth]
disable_login_form = true

[auth.anonymous]
enabled = true
org_name = IUT
org_role = Admin

```

```sh
systemctl enable --now grafana-server
```

Accéder à Grafana depuis votre navigateur

http://100.68.98.xx:3000/


## Intallation

### Sur PC avec Docker

```shell
docker pull grafana/grafana:12.1

docker run --detach --name grafana \
  --network proxy_net \
  --network tp_net \
  --network pgsql_net \
  -e "GF_SECURITY_ADMIN_USER=admin" \
  -e "GF_SECURITY_ADMIN_PASSWORD=geii2025" \
  -e "GF_USERS_ALLOW_SIGN_UP=false" \
  -e "GF_USERS_DEFAULT_THEME=system" \
  --label "caddy=grafana.localhost" \
  --label "caddy.reverse_proxy={{upstreams 3000}}" \
  --label "caddy.tls=internal" \
  grafana/grafana:12.1
```

### Sur Raspberry

Ajout de la clé du dépôt

```shell
wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -
```

Ajout du dépôt pour apt

```shell
echo "deb https://packages.grafana.com/oss/deb stable main" | tee -a /etc/apt/sources.list.d/grafana.list
```

Mise à jour du catalogue des paquets disponibles depuis les dépôts

```shell
apt update
```

Installation

Installer le [paquet logiciel](/linux/paquet/) `grafana`.


Activation du service

```shell
systemctl enable --now grafana-server
```

Ouvrir avec un navigateur l'adresse suivante :
[http://iutsd-raspberry30-896.ad.univ-lorraine.fr:3000/](http://iutsd-raspberry30-896.ad.univ-lorraine.fr:3000/)

utilsateur : `admin`\
Mot de passe : `admin`

Stocker le nouveau mot de passe dans KeePass.


### Plugins

```shell
grafana-cli plugins install grafana-worldmap-panel
grafana-cli plugins install simpod-json-datasource
```

## Ajouter une source de données

Ajouter Prometheus

Ajouter InfluxDB

## Ajouter un tableau de bord

Importer un dashoboard

Node Exporter Full | 1860
MySQL Exporter Quickstart and Dashboard | 14057

Dashboard pour une source Telegraf : 928
