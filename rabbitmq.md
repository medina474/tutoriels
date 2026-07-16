RabbitMQ

```shell
docker run --detach --name rabbitmq \
  --network proxy_net \
  -p "5672:5672" -p "1883:1883" \
  -e "PRABBITMQ_DEFAULT_USER=admin" \
  -e "RABBITMQ_DEFAULT_PASS=ChangeMe" \
  -e "RABBITMQ_SERVER_ADDITIONAL_ERL_ARGS=-rabbitmq_mqtt tcp_listeners [1883]" \
  -v rabbitmq_data:/var/lib/rabbitmq \
  -l "caddy=rabbitmq.localhost" \
  -l "caddy.reverse_proxy={{upstreams 15672}}" \
  -l "caddy.tls=internal" \
  rabbitmq:4.1.4-management \
  sh -c "rabbitmq-plugins enable --offline rabbitmq_mqtt rabbitmq_management && rabbitmq-server"
```

rabbitmq:

      - "5672:5672"     # AMQP
      - "1883:1883"     # MQTT
      
