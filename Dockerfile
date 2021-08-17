FROM alpine:3.12
LABEL description="WireGuard server"
LABEL maintainer="rainier b1916320@planet.kanazawa-it.ac.jp"

RUN apk add -U wireguard-tools
COPY config.conf ./
COPY setup.sh ./
RUN  chmod +x ./setup.sh

