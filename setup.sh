#!/bin/sh
ip link add dev wg0 type wireguard
ip address add dev wg0 10.0.0.1/24
wg setconf wg0 config.conf
ip link set up dev wg0