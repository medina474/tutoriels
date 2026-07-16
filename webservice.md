
# PostgREST
# Serve a fully RESTful API from any existing PostgreSQL database.
# It provides a cleaner, more standards-compliant, faster API than you are likely to write from scratch.
# https://docs.postgrest.org/en/v13/
  postgrest:
    image: postgrest/postgrest:v13.0.7
    restart: "no"
    depends_on:
      database:
        condition: service_healthy
      caddy:
        condition: service_started
    command: postgrest
    environment:
      PGRST_DB_URI: postgres://${POSTGREST_USER:-postgrest}:${POSTGREST_PASSWORD}@${POSTGREST_HOST:-database}:${POSTGREST_DB_PORT:-5432}/${COMPOSE_PROJECT_NAME}
      PGRST_DB_SCHEMAS: ${POSTGREST_DB_SCHEMAS:-public}
      PGRST_DB_ANON_ROLE: ${POSTGREST_DB_ANON_ROLE:-anonyme}
      PGRST_JWT_SECRET: ${POSTGREST_JWT_SECRET:-ChangeMeChangeMeChangeMeChangeMe}
      PGRST_ADMIN_SERVER_PORT: 3055
      PGRST_SERVER_PORT: 80
      PGRST_OPENAPI_SERVER_PROXY_URI: https://postgrest.localhost
    networks:
      - caddy_net
    labels:
      caddy: postgrest.localhost
      caddy.reverse_proxy: "{{upstreams 80}}"
      caddy.tls: internal

## Scalar

Create world-class API Docs with a built-in interactive playground which seamlessly turns to a full featured API Client

```shell
docker run --detach --name scalar \
    environment:
      API_REFERENCE_CONFIG: |
        {
          "sources":[
            { "url": "https://postgrest.localhost" }
          ],
          "theme": "purple"
        }
    networks:
      - proxy_net
    labels:
      caddy: scalar.localhost
      caddy.reverse_proxy: "{{upstreams 8080}}"
      caddy.tls: internal
    scalarapi/api-reference:0.4.2
```
