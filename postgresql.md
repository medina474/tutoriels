# PostgreSQL

## Debian

```shell
apt install -y postgresql-common
/usr/share/postgresql-common/pgdg/apt.postgresql.org.sh

apt install postgresql-18
```

## Docker

```shell
docker build -t iut/pgsql:2025-13 -f postgresql.Dockerfile .
```


```shell
docker network create pgsql_net
```

```shell
docker run --detach --name pgsql \
  --network pgsql_net \
  -p "5432:5432" \
  -e "POSTGRES_INITDB_ARGS=--locale-provider=icu --icu-locale=fr-FR" \
  -e "POSTGRES_PASSWORD=ChangeMe" \
  -e "POSTGRES_USER=iut" \
  -v pgsql_data:/var/lib/postgresql \
  -v "./:/docker-entrypoint-initdb.d" \
  -v "./data:/tmp" \
  iut/pgsql:2025-13
```

## pgAdmin

```shell
docker run --detach --name pgadmin \
  --network pgsql_net \
  --network proxy_net \
  -v "pgadmin:/var/lib/pgadmin/" \
  -e "PGADMIN_DISABLE_POSTFIX=true" \
  -e "PGADMIN_DEFAULT_EMAIL=p@toto.fr" \
  -e "PGADMIN_DEFAULT_PASSWORD=ChangeMe" \
  --label "caddy=pgadmin.localhost" \
  --label "caddy.reverse_proxy={{upstreams 80}}" \
  --label "caddy.tls=internal" \
  dpage/pgadmin4:9.11
```

```
    configs:
      - source: pgadmin_config
        target: /pgadmin4/servers.json
```


### Base de données

```sql
GRANT <privileges> ON DATABASE dbname TO role;
```

| Privilège        | Effet                        |
| ---------------- | ---------------------------- |
| CONNECT          | Se connecter à la base       |
| CREATE           | Créer des schémas            |
| TEMP / TEMPORARY | Créer des tables temporaires |

---

### Schéma

```sql
GRANT <privileges> ON SCHEMA schemaname TO role;
```

| Privilège | Effet                                        |
| --------- | -------------------------------------------- |
| USAGE     | Accéder aux objets du schéma                 |
| CREATE    | Créer tables, vues, fonctions dans ce schéma |

---

### Tables / Vues

```sql
GRANT <privileges> ON TABLE tablename TO role;
```

| Privilège  | Effet                     |
| ---------- | ------------------------- |
| SELECT     | Lire                      |
| INSERT     | Insérer                   |
| UPDATE     | Mettre à jour             |
| DELETE     | Supprimer                 |
| TRUNCATE   | Vider la table            |
| REFERENCES | Créer des clés étrangères |
| TRIGGER    | Créer des triggers        |

---

### Séquences

```sql
GRANT <privileges> ON SEQUENCE seq TO role;
```

| Privilège | Effet                |
| --------- | -------------------- |
| USAGE     | Utiliser `nextval()` |
| SELECT    | Lire la valeur       |
| UPDATE    | Modifier la valeur   |

---

### Fonctions / Procédures

```sql
GRANT <privileges> ON FUNCTION func TO role;
```

| Privilège | Effet               |
| --------- | ------------------- |
| EXECUTE   | Appeler la fonction |

---

### Types

```sql
GRANT <privileges> ON TYPE mytype TO role;
```

| Privilège | Effet            |
| --------- | ---------------- |
| USAGE     | Utiliser le type |

---

### Rôles

```sql
GRANT role1 TO role2;
```

| Privilège  | Effet                            |
| ---------- | -------------------------------- |
| membership | role2 hérite des droits de role1 |

---

### Tous les objets d’un schéma

```sql
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA api TO cocagne;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA api TO cocagne;
GRANT ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA api TO cocagne;
```


Tables existantes

GRANT SELECT ON ALL TABLES IN SCHEMA public TO lecteur;


Tables futures

ALTER DEFAULT PRIVILEGES
IN SCHEMA public
GRANT SELECT ON TABLES TO lecteur;

SELECT grantee, privilege_type
FROM information_schema.role_table_grants
WHERE table_name = 'ma_table';
s
