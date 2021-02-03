frontend fe_srv${NUM}
  bind 0.0.0.0:${PROXY_PORT} ${ACCEPT_PROXY}
  mode tcp
  timeout client ${CONNECTION_TIMEOUT}
  default_backend be_srv${NUM}

backend be_srv${NUM}
  mode tcp
  timeout server ${CONNECTION_TIMEOUT}
  timeout connect 5s
  server srv${NUM} ${SERVICE_NAME}:${SERVICE_PORT} check ${SEND_PROXY} resolvers docker-dns

