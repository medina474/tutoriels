# Accès à distance avec SSH

### Authentification par clé.

Vous déposer sur le serveur votre clé publique. Cette clé peut être utilisée par une multitude de serveurs. Elle est publique et n'a pas d'importance toute seule.

Votre clé privée est chiffrée et stockée sur votre machine (dans KeePass). Elle doit rester absolument secrète.

Lorsque vous voulez vous connecter au serveur, vous commencez par déchiffrer votre clé privée pour pouvoir l'utiliser. Vous utiliser le mot de passe qui chiffre la clé privée.

> Le mot de passe du compte n'a rien à voir avec le mot de passe qui chiffre la clé privée.

Il est même conseillé de désactiver le mot de passe du compte et de n'authoriser que la connexion avec les clés publiques/privées.

Vous chiffrez un message sans importance, comme la date et l'heure courante.

Vous transmettez ce message au serveur. Si le serveur arrive à déchiffrer ce message alors c'est que c'est bien vous le possesseur de la clé privée qui essayez de vous connecter.

#### Attaque par rejeu ou Replay attack

En utilisant la date et l'heure vous empêcher quelqu'un de réutiliser votre message pour se connecter en effet le serveur voyant que le message est daté ne permettra pas la connexion.

Le serveur peut aussi vous envoyez un nombre aléatoire valide quelques minutes seulement (token de session), si vous renvoyez ce même identifiant chiffré alors vous êtes la bonne personne.

### Agent

Un agent est un petit programme qui garde votre clé privée déchiffrée en mémoire pendant toute la durée d'une session. Cela évite de devoir renseigner la mot de passe de déchiffrement chaque fois que la clé doit être utilisée. Il existe plusieurs programe comme `ssh-agent`, `pageant` ou `KeeAgent`.

## Installation

```shell
apt install --no-install-recommends openssh-server
```

Copier / coller votre clé publique dans le fichier `~/.ssh/authorized_keys`


```shell
nano .ssh/authorized_keys
chmod 600 .ssh/authorized_keys
```

## SFTP

> ***SFTP*** est un protocole de communication fonctionnant au-dessus de `SSH` pour transférer et gérer des fichiers à distance.

:warning: Il ne faut pas confondre **sftp** avec **ftps**. Les 2 protocoles offrent les mêmes fonctionnalités de transfert de fichiers.  Cependant le **ftps** fonctionne sur la base du **ftp** en l'encapsulant dans une couche SSL/TLS alors que le **sftp** fonctionne au dessus de ***ssh**.


Créer le groupe `sftp`.

```shell
groupadd --system sftp
```
