FROM alpine:3.12
LABEL description="WireGuard server"
LABEL maintainer="rainier b1916320@planet.kanazawa-it.ac.jp"
WORKDIR /etc/wireguard
RUN apk add -U wireguard-tools
COPY config.conf wg0.conf
COPY setup.sh setup.sh
RUN  chmod +x setup.sh

