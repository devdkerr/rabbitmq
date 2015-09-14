FROM ubuntu:trusty
MAINTAINER Daniel R. Kerr <daniel.r.kerr@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

COPY rabbitmq.gpg /root/rabbitmq.gpg
RUN apt-key add /root/rabbitmq.gpg \
 && echo "deb http://www.rabbitmq.com/debian/ testing main" > /etc/apt/sources.list.d/rabbitmq.list

RUN apt-get update \
 && apt-get install -y -q monit rabbitmq-server supervisor \
 && apt-get clean \
 && rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

RUN rabbitmq-plugins enable rabbitmq_management \
 && rabbitmq-plugins enable rabbitmq_management_visualiser \
 && rabbitmq-plugins enable rabbitmq_stomp \
 && rabbitmq-plugins enable rabbitmq_web_stomp \
 && echo "[{rabbit, [{heartbeat, 0}, {loopback_users, []}]}]." > /etc/rabbitmq/rabbitmq.config

RUN mkdir /var/run/rabbitmq \
 && chown rabbitmq /var/run/rabbitmq
ENV RABBITMQ_PID_FILE /var/run/rabbitmq/rabbitmq.pid

COPY monitrc /etc/monit/monitrc
RUN chmod 700 /etc/monit/monitrc \
 && chown root:root /etc/monit/monitrc

VOLUME ["/var/log/rabbitmq", "/var/lib/rabbitmq/mnesia"]

EXPOSE 2812 5672 15672 15674

COPY supervisord.conf /etc/supervisord.conf
CMD ["/usr/bin/supervisord"]
