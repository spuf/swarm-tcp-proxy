#!/bin/sh
set -euo pipefail

gomplate -f /usr/local/etc/haproxy/haproxy.cfg.tmpl -o /usr/local/etc/haproxy/haproxy.cfg

if [ -n "$PRINT_CONFIG" ]; then
  cat /usr/local/etc/haproxy/haproxy.cfg
fi

exec /docker-entrypoint.sh $*
