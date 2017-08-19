#!/bin/sh

# for fuck gfw
iptables -A INPUT -p tcp --tcp-flags RST RST -j DROP

mkdir -p /mnt/sync/folders
mkdir -p /mnt/sync/config

exec /usr/local/bin/rslsync --config /etc/sync.conf --nodaemon $*
