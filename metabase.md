```shell
docker run --detach --name metabase \
  --network proxy_net \
  -e "MB_DB_TYPE=postgres" \
  -e "MB_DB_HOST=pgsql" \
  -e "MB_DB_PORT=5432" \
  -e "MB_DB_USER=metabase_user" \
  -e "MB_DB_PASS=supermotdepasse" \
  -e "MB_DB_DBNAME=metabase" \
  -e "MB_SITE_LOCALE=fr" \
  -e "MB_ADMIN_EMAIL=etudiant@univ-lorraine.fr" \
  -e "MB_ANON_TRACKING_ENABLED=false" \
  -e "MB_CHECK_FOR_UPDATES=false" \
  -e "MB_NO_SURVEYS=yes" \
  -e "MB_START_OF_WEEK=monday" \
  -e "MB_CUSTOM_FORMATTING: '{"type/Temporal":{"time_style":"HH:mm","date_style":"D MMMM, YYYY",-e "date_abbreviate":true},"type/Currency":{"currency":"EUR"},"type/Number":{"number_separators":", "}}'
  -e "MB_EMAIL_SMTP_HOST=mailpit"
  -e "MB_EMAIL_SMTP_PORT=1025"
  -e "MB_EMAIL_FROM_ADDRESS=metabase@univ-lorraine.fr"
  metabase/metabase:v0.56.5.5
```
  #   volumes:
  #     - /dev/urandom:/dev/random:ro
  #   environment:

  #
  #   networks:
  #     - caddy_net
  #   labels:
  #     caddy: metabase.localhost
  #     caddy.reverse_proxy: "{{upstreams 3000}}"
  #     caddy.tls: internal

```sql
-- Metabase

create role metabase_user with
  login
  nosuperuser
  nocreatedb
  nocreaterole
  noinherit
  noreplication
  connection limit -1
  password 'supermotdepasse';

create database metabase with
  owner metabase_user;

grant connect
  on database cocagne
  to metabase_user;

grant usage
  on schema public
  to metabase_user;

-- Pour toutes les tables du schéma public
grant select
  on all tables
  in schema public
  to metabase_user;

-- Privilège par défaut pour que chaque nouvelle table créée dans public donnera automatiquement le droit SELECT à metabase.
alter default privileges
  in schema public
  grant select
    on tables
    to metabase_user;
```
