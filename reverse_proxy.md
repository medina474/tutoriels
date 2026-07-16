# Reverse Proxy

Le **reverse proxy** joue le rôle de **point d’entrée unique** vers l’ensemble des services du système. Plutôt que d’exposer chaque application ou microservice sur un port ou une adresse distincte, toutes les requêtes passent par le proxy, qui se charge de les rediriger vers la bonne destination selon le nom de domaine, le chemin ou d’autres critères.

Ce modèle centralisé simplifie la configuration réseau, facilite la sécurisation des échanges (par exemple avec un certificat TLS unique), et permet d’ajouter des fonctionnalités transversales comme la journalisation, la mise en cache, ou la limitation de débit.

Ainsi, le proxy agit comme une **porte d’accès intelligente** qui distribue le trafic de manière transparente vers une multitude de services internes, tout en présentant une interface cohérente et unifiée aux utilisateurs externes.

Créer un réseau spécifique pour le serveur proxy

```shell
docker network create proxy_net
```

## Caddy Docker Proxy

```shell
docker run --detach --name caddy-docker-proxy --restart=always \
  --network proxy_net -p "80:80" -p ""443:443/tcp"" -p "443:443/udp" \
  -e "CADDY_INGRESS_NETWORKS=proxy_net" \
  -v caddy_config:/config \
  -v caddy_data:/data \
  -v /var/run/docker.sock:/var/run/docker.sock:ro \
  -v "$(pwd)/www:/srv/www:ro" \
  --label "caddy=localhost" \
  --label "caddy.root=* /srv/www" \
  --label "caddy.file_server=" \
  --label "caddy.tls=internal" \
  lucaslorentz/caddy-docker-proxy:2.10
```

  caddy.file_server: ""   # Active le serveur de fichiers statiques
  caddy.tls: internal     # HTTPS auto-signé géré par Caddy

Pour l'invite de commande Windows remplacer `\` par `^` et `$(pwd)/` par `%cd%\`

## WhoAmI

Ce mini serveur Go affiche des informations sur la requête http. Utile pour tester le bon fonctionnement du proxy.

```shell
docker run --detach --name whoami \
  --network proxy_net \
  --label "caddy=whoami.localhost" \
  --label "caddy.reverse_proxy={{upstreams 80}}" \
  --label "caddy.tls=internal" \
    traefik/whoami
```

## Toxiproxy

Toxiproxy est un outil open source développé par Shopify qui agit comme un proxy TCP permettant de simuler diverses conditions réseau, telles que la latence, la perte de paquets ou les coupures de connexion, afin de tester la résilience des applications.

Il est conçu pour les environnements de développement, d'intégration continue et de test, offrant une API dynamique pour injecter des perturbations réseau (appelées toxics) de manière contrôlée ou aléatoire.

Grâce à Toxiproxy, les développeurs peuvent identifier les points de défaillance potentiels de leurs systèmes distribués et améliorer la tolérance aux pannes en simulant des scénarios de dégradation réseau réalistes.

```shell
docker run --detach --name toxiproxy \
  --network proxy_net \
  --label "caddy_0=toxiproxy.localhost" \
  --label "caddy_0.reverse_proxy={{upstreams 8474}}" \
  --label "caddy_0.tls=internal" \
  --label "caddy_1=whoami.toxic.localhost" \
  --label "caddy_1.reverse_proxy={{upstreams 9001}}" \
  --label "caddy_1.tls=internal" \
    ghcr.io/shopify/toxiproxy
```

VOIR la configuration
