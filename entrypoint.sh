#!/bin/sh

set -eu

: "${CHAT_AUTH_USER:?Не задан CHAT_AUTH_USER}"
: "${CHAT_AUTH_PASSWORD:?Не задан CHAT_AUTH_PASSWORD}"
: "${CHAT_WEBHOOK_URL:?Не задан CHAT_WEBHOOK_URL}"

htpasswd -bc /etc/nginx/.htpasswd \
  "$CHAT_AUTH_USER" \
  "$CHAT_AUTH_PASSWORD"

envsubst '${CHAT_WEBHOOK_URL}' \
  < /usr/share/nginx/html/config.template.js \
  > /usr/share/nginx/html/config.js

exec nginx -g 'daemon off;'
