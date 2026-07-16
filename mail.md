# Mail

## Mailpit

Mailpit est un outil open source conçu pour **intercepter** et **visualiser** les e-mails envoyés par une application pendant le développement ou les tests.

Il agit comme un serveur SMTP local (vers lequel l’application envoie les messages) et fournit une interface web pour consulter ces e-mails sans qu’ils soient réellement envoyés à Internet.

Le port d'écoute SMTP est le 1025 (25 normalement) et l'interface d'administation écoute sur le port 8025.

```shell
docker run --detach --name mailpit \
  --network proxy_net \
  -e "TZ=Europe/Paris" \
  -p "1025:1025" \
  --label "caddy=mailpit.localhost" \
  --label "caddy.reverse_proxy={{upstreams 8025}}" \
  --label "caddy.tls=internal" \
    axllent/mailpit:v1.25
```

Dans cet exemple l'interface d'administration est placée derrière le [reverse proxy](reverse_proxy.md).
