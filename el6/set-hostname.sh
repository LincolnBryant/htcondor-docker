#!/bin/sh

DEV=$(ip -4 route show default | cut -d" " -f5)
IP4=$(ip -4 address show dev eno1 | grep inet | tr " " / | cut -d/ -f6)
FQDN=$(hostname)
HOSTNAME=$(hostname -s)

echo -e "$IP4\t$HOSTNAME\t$FQDN" >> /etc/hosts
