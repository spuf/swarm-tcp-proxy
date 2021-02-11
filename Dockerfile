FROM haproxy:2.2-alpine

COPY --from=hairyhenderson/gomplate:v3-alpine /bin/gomplate /bin/gomplate

COPY custom-entrypoint.sh /
COPY haproxy.cfg.tmpl /usr/local/etc/haproxy/haproxy.cfg.tmpl

ENTRYPOINT ["/custom-entrypoint.sh"]
CMD ["haproxy", "-f", "/usr/local/etc/haproxy/haproxy.cfg"]
