#!/bin/sh

# for fuck gfw
iptables -A INPUT -p tcp --tcp-flags RST RST -j DROP
iptables -A OUTPUT -p tcp --tcp-flags RST RST -j DROP
iptables -I INPUT -p tcp --tcp-flags ALL RST,ACK -j DROP
iptables -I OUTPUT -p tcp --tcp-flags ALL RST,ACK -j DROP

mkdir -p /mnt/sync/folders
mkdir -p /mnt/sync/config

exec /usr/local/bin/rslsync --config /etc/sync.conf --nodaemon $*
