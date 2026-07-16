# InfluxDB

title: Base de données de mesures chronologiques


> ***Time Series Database (TSDB)*** : base de données optimisée pour les grands volumes de données ordonnés chronologiquement, les mesures et événements horodatées.

## Liste des TSDB

Produit|Langage|Site
|-|-|-|
InfluxDB | Go | [influxdata.com](https://www.influxdata.com/)
Prometheus |	Go | [prometheus.io](https://prometheus.io/)
OpenTSDB | | [opentsdb.net](http://opentsdb.net/)
Apache Druid | Java | [druid.apache.org](https://druid.apache.org/)
Apache Kudu |	C++ | [kudu.apache.org](https://kudu.apache.org/)
Whisper (Graphite)	|	Python | [graphiteapp.org](https://graphiteapp.org/)
eXtremeDB |	| [mcobject.com](https://www.mcobject.com/)
IBM Informix TimeSeries	|	C / C++ | [ibm.com](https://www.ibm.com/docs/en/informix-servers)
Kx kdb+ |	[Q](https://code.kx.com/q/) | [code.kx.com](https://code.kx.com/home/)
Riak-TS	|	Erlang | [riak.com](https://riak.com/)
RRDtool	|	C | [https://oss.oetiker.ch/rrdtool/](https://oss.oetiker.ch/rrdtool/)

## InfluxDB

**InfluxDB** est un moteur de base de données, organisé en séries de temps (Time Series). Il s’agit d’un ensemble de valeurs collectés à intervalles réguliers sur une période de temps donnée.
Elle supporte des charges élevées de lecture et d'écriture.

Ce type de base de données mesure les changements au fil du temps. Elle propose des fonctionnalités de gestion du cycle de vies des données, d’agrégation (summarization), et permet de parcourir de larges rangées d’enregistrements.

La clé primaire de chaque enregistrement est la date et l’heure de création de l'enregistrement.

La solution d'InfluxData comprend plusieurs briques logiciels :
-	Un collecteur de données `Telegraf`, capable de lire et recevoir des données suivant des formats et protocoles différents ;
-	Une base de données `InfluxDb`, qui stocke les données ;
-	Un visualiseur et requêteur de données `Chronograf` ;
-	Un analyseur de données `Kapacitor`.

Cette solution est utilisée en DevOps pour la surveillance des systèmes (nombre de requêtes par seconde, utilisation du processeur, de la mémoire, etc ...), les mesures d'applications (nombre d'envoi de mail par seconde, ...), les données de capteurs IoT et les analyses en temps réel.

### Installation sur PC

> Dans le cas ou un serveur PC surveille notre installation Raspberry.

```shell
docker pull influxdb:3.7-core
```

```shell
docker run --detach --name influxdb \
  --network proxy_net \
  --network tp_net \
  -p "8181:8181" \
  -v influxdb:/var/lib/influxdb3/data \
  -v influxdb_plugins:/var/lib/influxdb3/plugins \
  -l "caddy=influxdb.localhost" \
  -l "caddy.reverse_proxy={{upstreams 8181}}" \
  -l "caddy.tls=internal" \
  influxdb:3.7-core influxdb3 serve \
    --node-id=my-node-0 \
    --object-store=file \
    --data-dir=/var/lib/influxdb3/data \
    --plugin-dir=/var/lib/influxdb3/plugins
```


docker run --detach \
  --name influxdb3-explorer \
  --network tp_net \
  --publish 8888:80 \
  --publish 8889:8888 \
  influxdata/influxdb3-ui \
  --mode=admin



  influxdb:

    volumes:
      - influxdb_data:/var/lib/influxdb2
      - influxdb_config:/etc/influxdb2
```


### Installation sur Raspberry

> Dans le cas où le Raspberry est utilisé comme agent de surveillance de nos serveurs et machines.

Ajouter la clé gpg  `https://repos.influxdata.com/influxdb.key`dans le porte-clé du système.

```shell
wget -qO /usr/local/share/keyrings/influxdb.gpg https://repos.influxdata.com/influxdb.key
```

Convertir la clé au format gpg NE FONCTIONNE PAS

```shell
echo '23a1c8836f0afc5ed24e0486339d7cc8f6790b83886c4c96995b88a061c5bb5d influxdb.key' | sha256sum -c && cat influxdb.key | gpg --dearmor | sudo tee /usr/local/share/keyrings/influxdb.gpg > /dev/null

sha256sum -c 23a1c8836f0afc5ed24e0486339d7cc8f6790b83886c4c96995b88a061c5bb5d influxdb.key
```

 influxdb.key GPG Fingerprint: 05CE15085FC09D18E99EFB22684A14CF2582E0C5


echo 'deb [signed-by=/etc/apt/keyrings/influxdb.gpg] https://repos.influxdata.com/debian stable main' | sudo tee /etc/apt/sources.list.d/influxdata.list

sudo apt-get update && sudo apt-get install telegraf

```shell session
#ajout du dépôt pour apt
echo "deb [signed-by=/usr/local/share/keyrings/influxdb.gpg] https://repos.influxdata.com/debian stable main" | sudo tee /etc/apt/sources.list.d/influxdata.list

#mise à jour de la liste des paquets contenus dans les dépôts
apt update
```

Installer le [paquet logiciel](/linux/paquet/) `influxdb`.

Activer le service influxdb

```shell
systemctl enable --now influxdb
```

#### Mode client

```shell
influx
```

```shell
# Créer une base de données
> CREATE DATABASE iutsd

# Vérifier la présence de la base de données
> SHOW DATABASES

# Se placer dans la base de donnée
> USE iutsd

# Insérer une donnée dans la base
> INSERT nom,numero=127 solde=60.0
```

Visualiser les données

```shell
> SELECT solde FROM nom
```

Structure d'une donnée

```
mesure[,<tag-key>=<valeur>...] <grandeur1>=<valeur>[,<grandeur2>=<valeur2>...] [unix-nano-timestamp]
```

Un mesure est associée à une ou plusieures étiquette.

### Collecteur de données

Installer le [paquet logiciel](/linux/paquet/) `telegraf`.

```shell
systemctl enable --now telegraf
```

Activer la collecte depuis le protocole MQTT


## Liens externes
- [Influx](https://www.influxdata.com/)

:time stamped
  données horodaté, reliée à un temps précis.
