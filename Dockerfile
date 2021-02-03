FROM haproxy:2.2.8-alpine

ENV CONNECTION_TIMEOUT=5m
ENV STATS_ADDR=0.0.0.0:3333
ENV DISABLE_PROXY_PROTOCOL=""
ENV ACCEPT_PROXY_PROTOCOL=""

COPY custom-entrypoint.sh /
COPY haproxy/* /usr/local/etc/haproxy/

ENTRYPOINT ["/custom-entrypoint.sh"]
CMD ["haproxy", "-f", "/usr/local/etc/haproxy/haproxy.cfg"]
