# Gestion des paquets logiciels avec APT

## Effectuer une mise à jour du système.

> [!NOTE]
> Sans être connecté à l'utilisateur root, il est nécessaire d'utiliser la précommande _sudo_ (_substitute user do ..._) à chaque ligne.

```shell
apt update
apt list --upgradable
apt upgrade -y
```
Il est possible de chainer plusieurs commande sur une seule ligne, en utilisant l'opérateur `&&`.

```shell
apt update && apt upgrade -y
```

`apt update` permet de mettre à jour les catalogues contenant la liste des différentes versions des paquets disponibles.

`apt list --upgradable` permet de lister les paquets qui doivent être mise à jour.

`apt upgrade` permet d'appliquer les mises à jour trouvées, le commutateur `-y` permet d'accepter automatiquement toutes les demandes.


Lister les paquets installés

```shell
apt list --installed
```
