#!/bin/sh
set -euo pipefail

if [[ -z "$SERVICES" ]]; then
  echo "SERVICES is not defined"
  exit 1
fi

haproxy_cfg_dir="/usr/local/etc/haproxy"
haproxy_cfg="$haproxy_cfg_dir/haproxy.cfg"

sed "s/\${STATS_ADDR}/${STATS_ADDR}/" "$haproxy_cfg_dir/header.cfg.tpl" > "$haproxy_cfg"

num=0
for service in $SERVICES; do
  let "num++" || true
  name="$(echo $service | cut -d ":" -f 1)"
  port="$(echo $service | cut -d ":" -f 2)"
  sed "s/\${NUM}/${num}/; \
    s/\${PROXY_PORT}/${port}/; \
    s/\${SERVICE_NAME}/${name}/; \
    s/\${SERVICE_PORT}/${port}/; \
    s/\${CONNECTION_TIMEOUT}/${CONNECTION_TIMEOUT}/g" "$haproxy_cfg_dir/service.cfg.tpl" >> "$haproxy_cfg"
done

send_proxy_arg="send-proxy"
if [ -n "$DISABLE_PROXY_PROTOCOL" ]; then
  send_proxy_arg=""
fi
sed -i "s/\${SEND_PROXY}/${send_proxy_arg}/" "$haproxy_cfg"

accept_proxy_arg=""
if [ -n "$ACCEPT_PROXY_PROTOCOL" ]; then
  accept_proxy_arg="accept-proxy"
fi
sed -i "s/\${ACCEPT_PROXY}/${accept_proxy_arg}/" "$haproxy_cfg"

cat /usr/local/etc/haproxy/haproxy.cfg

exec /docker-entrypoint.sh $*
