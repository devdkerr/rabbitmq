Dockerized RabbitMQ
========================================

A dockerized RabbitMQ service, with Monit monitoring.

Docker Run
----------------------------------------

```bash
docker run -d -p "2812" -p "5672:5672" -p "15672:15672" -p "15674:15674" devdkerr/rabbitmq
```

Docker-Compose Run
----------------------------------------

```yaml
rabbitmq:
    image: devdkerr/rabbitmq
    ports:
     - "2812"
     - "5672:5672"
     - "15672:15672"
     - "15674:15674"
```
