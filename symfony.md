# Symfony

## Option A : Installation sur le poste local

Installer le client Symfony

https://symfony.com/download

Vérifier les prérequis.

```shell
symfony check:requirements
```

Créer le projet.

```shell
composer create-project symfony/skeleton:"8.1.*" sae5_xxx_yyy
cd sae5_xxx_yyy
```

Il est préférable de partir le gabarit minimal, plutôt que sur le gabarit webapp. Il est important de comprendre les différents modules qui seront installés, plutôt que ne pas utiliser ceux présents par défaut sans comprendre leur utilité.

Afficher les informations du projet en cours.

```shell
php bin/console about
```

Démarrer le serveur web intégré.

```shell
symfony server:start
```

## Option B : Développer dans un Dev Container

Dev Containers est une extension de Visual Studio Code qui crée un environnement de développement à l'intérieur d'un conteneur Docker. L'environnement est alors identique pour tous les membres de l'équipe, quel que soit leur système d'exploitation ou leur configuration locale. Par exemple le développeur A travaille sous Windows avec Php 8.2, B sous Mac avec Php 8.3 et C sous Linux avec Php 8.4.  Avec Dev Container les 3 travaillent avec la même version de Php.

Si l'extensions Dev Containers a été développée par Microsoft pour Visual Studio Code, c'est maintenant un standard repris par les autres IDE comme phpStorm.

https://blog.stephane-robert.info/docs/developper/autres-outils/ide/visual-studio-code/devcontainers/

Utiliser l'environnement officiel proposé par Kévin Dunglas : [Symfony Docker](https://github.com/dunglas/symfony-docker)


Kévin Dunglas est un contributeur actif au projet Symfony,où il a participé à plusieurs composants et améliorations, notamment autour des API, de la sérialisation et des standards du Web.

Ces principales contributions :

- **API Platform** : un framework construit sur Symfony permettant de développer rapidement des API REST, GraphQL et, plus récemment, des API temps réel. Il est utilisé par de nombreuses entreprises et administrations.
- **FrankenPHP** : un serveur d'applications PHP moderne basé sur Caddy, conçu pour améliorer les performances et simplifier le déploiement des applications PHP. Il prend en charge des fonctionnalités comme les workers, HTTP/2, HTTP/3 et HTTPS automatique. Il est compatible à de nombreux projets Php comme Laravel et Wordpress.
- **Mercure** : un protocole et un hub permettant de diffuser des mises à jour en temps réel vers les navigateurs via les technologies web standard.
- **Vulcain** : une proposition visant à optimiser les API hypermédia en réduisant le nombre de requêtes HTTP nécessaires grâce à des mécanismes standardisés.

Télécharger le dépôt et l'ouvrir avec Visual Studio Code, équipée de l'extension [Dev Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

sous Linux, adapter à la fin les permissions sur les fichiers.

```shell
docker compose exec php chown -R $(id -u):$(id -g) .
```

## Composants de développement

```shell
composer require --dev xxx/xxx
```

* **symfony/maker-bundle** : Génère du code standard prêt à être personnalisé (CRUD, entités, contrôleurs) via la ligne de commande. Il standardise la structure et les bonnes pratiques Symfony. Cette commande est très utiles quand il faut créer simultanément plusieurs fichiers liés en même temps.

* **symfony/debug-pack** : Fournit un ensemble d’outils de debug (profiler, var-dumper, logs améliorés) pour analyser le comportement de l’application. Ajoute la célèbre barre de développement de Symfony.

* **symfony/test-pack** : Meta-package qui installe et configure les outils de test (comme PHPUnit) prêts à l’emploi. Il simplifie la mise en place d’une stratégie de tests dans Symfony.

* **phpstan/phpstan-symfony** : Intègre PHPStan un outil qui analyse le code source afin de détecter les erreurs potentielles.


```shell
composer require --dev symfony/maker-bundle symfony/debug-pack symfony/test-pack phpstan/phpstan-symfony
```

```shell
php bin/phpunit
```

Lister toutes les commandes associées à Symfony Maker

```shell
php bin/console list make
```

```shell
vendor/bin/phpstan analyse src
```

## Composants frontend

```shell
composer require xxx/xxx
```

* **symfony/twig-bundle** : Intègre le moteur de templates Twig dans Symfony. Il permet de générer les vues HTML et fournit de nombreuses fonctionnalités spécifiques à Symfony.

* **symfony/asset** : Fournit des outils pour générer les URLs des ressources statiques (CSS, JavaScript, images). Il facilite également la gestion des versions d'assets pour le cache navigateur.

* **symfony/asset-mapper** : Permet de gérer et exposer les fichiers CSS, JavaScript et autres ressources sans avoir besoin d'un bundler comme Webpack. Il résout automatiquement les dépendances ES Modules et optimise la gestion des assets.

```shell
composer require symfony/twig-bundle symfony/asset symfony/asset-mapper
```

### Tailwind CSS

* **symfonycasts/tailwind-bundle** : Intègre Tailwind CSS dans Symfony avec une configuration simplifiée. Il permet de compiler automatiquement les styles Tailwind durant le développement et le déploiement.

```shell
php bin/console tailwind:init
```

#### Compilation continue avec Tailwind

fichier `.symfony.local.yaml`

```yaml
workers:
    tailwind:
        cmd: ['symfony', 'console', 'tailwind:build', '--watch']
```

### JavaScript

* **symfony/stimulus-bundle** : Intègre le framework JavaScript Stimulus dans Symfony. Il facilite l'ajout de comportements interactifs côté client tout en conservant une architecture simple et progressive.

* **symfony/ux-turbo** :

```shell
composer require symfony/stimulus-bundle symfony/ux-turbo
```

## Composants backend

* **symfony/orm-pack** : Pack de dépendances qui installe et configure Doctrine ORM pour Symfony. Il simplifie la mise en place de la persistance des données relationnelles.

* **symfony/form** : Fournit un système complet de création, affichage et traitement de formulaires. Il gère automatiquement le mapping entre les données soumises et les objets métier.

* **symfony/validator** : Permet de valider les données à l'aide de règles déclaratives. Il est couramment utilisé pour vérifier les entités, les DTO et les données de formulaires.

* **symfony/mailer** : Fournit une API unifiée pour l'envoi d'e-mails. Il prend en charge de nombreux transports comme SMTP, SendGrid, Mailgun ou Amazon SES.

* **symfony/ux-icons** : Permet d'utiliser facilement des bibliothèques d'icônes dans les templates Twig. Les icônes sont intégrées comme composants réutilisables et optimisées automatiquement.

* **monolog-bundle** : Intègre la gestion des journaux d'événements (logs). Il permet de configurer plusieurs canaux et destinations comme des fichiers, bases de données ou services externes.

* **symfony/messenger** : Fournit un système de bus de messages pour découpler les traitements de l'application. Il permet d'exécuter des tâches de manière synchrone ou asynchrone via des files d'attente et des workers.


## Conposants de sécurité

* **symfony/security-bundle** : Implémente le système d'authentification et d'autorisation de Symfony. Il permet de gérer les utilisateurs, les rôles, les permissions et les mécanismes de connexion.

* **symfony/security-csrf** : Fournit une protection contre les attaques CSRF (Cross-Site Request Forgery). Il génère et valide des jetons de sécurité pour les formulaires et les actions sensibles.




#### Déploiement, passage en production

Créer un fichier `.env.local.php`

```shell
composer dump-env prod
```

Voir les valeurs réellement appliquée

```shell
php bin/console debug:dotenv
```

```shell
composer install --no-dev --optimize-autoloader
php bin/console tailwind:build --minify
php bin/console asset-map:compile
```

- phpstan/phpstan-doctrine (--dev)
- jsor/doctrine-postgis

- symfony/translation
(- knplabs/knp-paginator-bundle)

https://github.com/dunglas/symfony-docker?

## Première page

```shell
php bin/console make:controller HomeController
```

## Première entité

```shell
php bin/console make:entity
```

php bin/console make:migration


```shell
php bin/console make:crud Country
```

bin/console doctrine:migration:diff
composer require symfony/doctrine-messenger

Unknown database type "geometry" requested, Doctrine\DBAL\Platforms\PostgreSQL120Platform may
   not support it.

"symfony/maker-bundle": "^1.0",
        "symfony/debug-pack": "*",
        "symfony/test-pack": "*"

       "symfony/asset": "*",
        "symfony/asset-mapper": "*",
        "symfony/stimulus-bundle": "*",
        "symfony/ux-turbo": "*",

            "symfony/validator": "*",
                    "symfony/orm-pack": "*",
                    "symfony/form": "*",

"description": "A webapp pack on top of the default skeleton",
    "require": {

        "symfony/debug-pack": "*",
        "symfony/doctrine-messenger": "*",
        "symfony/expression-language": "*",
        "symfony/http-client": "*",
        "symfony/intl": "*",
        "symfony/mailer": "*",
        "symfony/maker-bundle": "^1.0",
        "symfony/mime": "*",
        "symfony/monolog-bundle": "^3.1|^4.0",
        "symfony/notifier": "*",
        "symfony/process": "*",
        "symfony/profiler-pack": "*",
        "symfony/security-bundle": "*",
        "symfony/serializer-pack": "*",
        "symfony/string": "*",
        "symfony/test-pack": "*",
        "symfony/translation": "*",
        "symfony/twig-pack": "bundle + extra",
        "symfony/web-link": "*"
    },
    "require-dev": {

        "symfony/profiler-pack": "*",

    },
