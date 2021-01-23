FROM ubuntu:bionic

ARG TYPE

RUN apt-get update \
  && apt-get install -y \
  bind9 \
  bind9utils \
  bind9-doc \
  dnsutils && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists

# Enable IPv4
RUN sed -i 's/OPTIONS=.*/OPTIONS="-4 -u bind"/' /etc/default/bind9

# Copy configuration files
COPY named.conf.options /etc/bind/
COPY named.conf.local /etc/bind/
COPY db.nagoya-foundation.com /etc/bind/zones/
COPY db.dns-teko.lu /etc/bind/zones/

# Run eternal loop
CMD ["/bin/bash", "-c", "while :; do sleep 10; done"]
