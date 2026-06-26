# Symfony

Installer le client Symfony

https://symfony.com/download

Vérifier les prérequis

```shell
symfony check:requirements
```

Créer le projet

```shell
composer create-project symfony/skeleton:"8.1.*" sae5_medina_rositi
```

```shell
php bin/console about
```

Démarrer le serveur web intégré

```shell
cd sae5_medina_rositi
symfony server:start
```

## Composants de développement

```shell
composer require --dev xxx/xxx
```

* **symfony/maker-bundle** : Génère du code standard prêt à être personnalisé (CRUD, entités, contrôleurs) via la ligne de commande. Il standardise la structure et les bonnes pratiques Symfony. Cette commande est très utiles quand il faut créer simultanément plusieurs fichiers liés en même temps.

* **symfony/test-pack** : Meta-package qui installe et configure les outils de test (comme PHPUnit) prêts à l’emploi. Il simplifie la mise en place d’une stratégie de tests dans Symfony.

* **symfony/debug-pack** : Fournit un ensemble d’outils de debug (profiler, var-dumper, logs améliorés) pour analyser le comportement de l’application. Ajoute la célèbre barre de développement de Symfony.

* **phpstan/phpstan-symfony** : Intègre PHPStan un outil qui analyse le code source afin de détecter les erreurs potentielles.

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

## Composants

```shell
composer require xxx/xxx
```

* **symfony/twig-bundle** : Intègre le moteur de templates Twig dans Symfony. Il permet de générer les vues HTML et fournit de nombreuses fonctionnalités spécifiques à Symfony.

* **symfony/asset** : Fournit des outils pour générer les URLs des ressources statiques (CSS, JavaScript, images). Il facilite également la gestion des versions d'assets pour le cache navigateur.

* **symfony/asset-mapper** : Permet de gérer et exposer les fichiers CSS, JavaScript et autres ressources sans avoir besoin d'un bundler comme Webpack. Il résout automatiquement les dépendances ES Modules et optimise la gestion des assets.

* **symfony/orm-pack** : Pack de dépendances qui installe et configure Doctrine ORM pour Symfony. Il simplifie la mise en place de la persistance des données relationnelles.

* **symfony/form** : Fournit un système complet de création, affichage et traitement de formulaires. Il gère automatiquement le mapping entre les données soumises et les objets métier.

* **symfony/validator** : Permet de valider les données à l'aide de règles déclaratives. Il est couramment utilisé pour vérifier les entités, les DTO et les données de formulaires.

* **symfony/mailer** : Fournit une API unifiée pour l'envoi d'e-mails. Il prend en charge de nombreux transports comme SMTP, SendGrid, Mailgun ou Amazon SES.

* **symfony/ux-icons** : Permet d'utiliser facilement des bibliothèques d'icônes dans les templates Twig. Les icônes sont intégrées comme composants réutilisables et optimisées automatiquement.

* **monolog-bundle** : Intègre la gestion des journaux d'événements (logs). Il permet de configurer plusieurs canaux et destinations comme des fichiers, bases de données ou services externes.

* **symfony/messenger** : Fournit un système de bus de messages pour découpler les traitements de l'application. Il permet d'exécuter des tâches de manière synchrone ou asynchrone via des files d'attente et des workers.


### Tailwind CSS

* **symfonycasts/tailwind-bundle** : Intègre Tailwind CSS dans Symfony avec une configuration simplifiée. Il permet de compiler automatiquement les styles Tailwind durant le développement et le déploiement.

### JavaScript

* **symfony/stimulus-bundle** : Intègre le framework JavaScript Stimulus dans Symfony. Il facilite l'ajout de comportements interactifs côté client tout en conservant une architecture simple et progressive.

### Sécurité

* **symfony/security-bundle** : Implémente le système d'authentification et d'autorisation de Symfony. Il permet de gérer les utilisateurs, les rôles, les permissions et les mécanismes de connexion.

* **symfony/security-csrf** : Fournit une protection contre les attaques CSRF (Cross-Site Request Forgery). Il génère et valide des jetons de sécurité pour les formulaires et les actions sensibles.


#### Compilation continue avec Tailwind

fichier `.symfony.local.yaml`

```yaml
workers:
    tailwind:
        cmd: ['symfony', 'console', 'tailwind:build', '--watch']
```

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
   
