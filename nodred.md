
```shell
docker run --detach --name nodered \
  --network proxy_net \
  --network tp_net \
  -p "1880:1880" \
  -v nodered:/data \
  -e "TZ=Europe/Paris" \
  -l "caddy=nodered.localhost" \
  -l "caddy.reverse_proxy={{upstreams 1880}}" \
  -l "caddy.tls=internal" \
  nodered/node-red:4.1
```
