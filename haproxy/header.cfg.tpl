global
  log fd@2 local2

defaults
  log global
  option tcplog

resolvers docker-dns
  nameserver dns1 127.0.0.11:53
  resolve_retries 3
  timeout resolve 1s
  timeout retry 1s
  hold valid 1s

frontend fe_stats
  bind ${STATS_ADDR}
  default_backend be_stats
  timeout client 5s

backend be_stats
  mode http
  stats enable
  stats uri /
  stats show-legends
  stats show-node

