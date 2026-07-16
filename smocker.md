## Web API Mock

**Smocker** est un outil de **mockage d’API REST** conçu pour faciliter le développement, les tests et l’intégration d’applications qui communiquent avec des services externes. Il permet de simuler facilement le comportement d’une API en définissant des **mocks** (réponses fictives) à partir de requêtes HTTP attendues.

Grâce à une interface web et une API de configuration, Smocker autorise la création dynamique de scénarios complexes : gestion d’états, réponses conditionnelles, délais simulés ou erreurs contrôlées.

Cet outil est particulièrement utile dans les environnements de test ou de développement où le service réel n’est pas encore disponible, instable, ou payant. En remplaçant temporairement les dépendances externes par des versions simulées, Smocker améliore la **rapidité**, la **prévisibilité** et la **fiabilité** des tests d’intégration et des pipelines CI/CD.

```shell
docker run --detach --name smocker \
  --network proxy_net \
  --label "caddy_0=smocker.localhost" \
  --label "caddy_0.reverse_proxy={{upstreams 8080}}" \
  --label "caddy_0.tls=internal" \
  --label "caddy_1=smocker.admin.localhost" \
  --label "caddy_1.reverse_proxy={{upstreams 8081}}" \
  --label "caddy_1.tls=internal" \
    thiht/smocker:0.18.5
```
