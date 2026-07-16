# Prometheus

## Debian 13

```shell
useradd --system --no-create-home --user-group --shell /usr/sbin/nologin prometheus

wget https://github.com/prometheus/prometheus/releases/download/v3.7.3/prometheus-3.7.3.linux-amd64.tar.gz

tar xvf prometheus-*.tar.gz
```

Déplacer les binaires

```shell
mv prometheus-*/prometheus /usr/local/bin/

mv prometheus-*/promtool /usr/local/bin/

chown prometheus:prometheus /usr/local/bin/prometheus

chown prometheus:prometheus /usr/local/bin/promtool
```

Créer le dossier de configuration

```shell
mkdir /etc/prometheus
mkdir /etc/prometheus/consoles
mkdir /etc/prometheus/console_libraries
mv prometheus-*/prometheus.yml /etc/prometheus
chown -R prometheus:prometheus /etc/prometheus
```

Créer le dossier pour les données

```shell
mkdir /var/lib/prometheus
chown -R prometheus:prometheus /var/lib/prometheus
```

Créer le service

```shell
nano /etc/systemd/system/prometheus.service
```

```
[Unit]
Description=Prometheus Monitoring
Wants=network-online.target
After=network-online.target

[Service]
User=prometheus
Group=prometheus
Type=simple
ExecStart=/usr/local/bin/prometheus \
  --config.file /etc/prometheus/prometheus.yml \
  --storage.tsdb.path /var/lib/prometheus/ \
  --web.console.templates=/etc/prometheus/consoles \
  --web.console.libraries=/etc/prometheus/console_libraries
Restart=always


[Install]
WantedBy=multi-user.target
```

```shell
systemctl daemon-reload
systemctl enable --now prometheus
```

## Raspberry Pi 3B+

```shell
wget https://github.com/prometheus/prometheus/releases/download/v3.7.3/prometheus-3.7.3.linux-armv7.tar.gz
tar xfz prometheus-3.7.3.linux-armv7.tar.gz
mv prometheus-3.7.3.linux-armv7 prometheus
rm prometheus-3.7.3.linux-armv7.tar.gz
sudo nano /etc/systemd/system/prometheus.service
```

```
[Unit]
Description=Prometheus Server
Documentation=https://prometheus.io/docs/introduction/overview/
After=network-online.target

[Service]
User=iut
Restart=on-failure

ExecStart=/home/iut/prometheus/prometheus \
  --config.file=/home/iut/prometheus/prometheus.yml \
  --storage.tsdb.path=/home/iut/prometheus/data

[Install]
WantedBy=multi-user.target
```

```shell
sudo systemctl enable --now prometheus
sudo systemctl status prometheus
```

## Docker

```shell
docker run --detach --name prometheus \
  --network proxy_net \
  -p "9090:9090" \
  -v prometheus:/prometheus \
  -v ./prometheus.yml:/etc/prometheus/prometheus.yml \
  -v ./prometheus:/etc/prometheus/targets \
  -v /var/run/docker.sock:/var/run/docker.sock:ro \
  -l "caddy=prometheus.localhost" \
  -l "caddy.reverse_proxy={{upstreams 9090}}" \
  -l "caddy.tls=internal" \
  prom/prometheus:v3.8.0
```

  prometheus:
    
    command:
      - '--config.file=/etc/prometheus/prometheus.yml'
    configs:
      - source: prometheus_config
        target: /etc/prometheus/prometheus.yml
    volumes:
      - 
    extra_hosts:
      - host.docker.internal=host-gateway

#/etc/docker/daemon.json
#{
#  "metrics-addr": "0.0.0.0:9323"
#}