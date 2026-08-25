#!/bin/sh

set -eu

: "${CHAT_AUTH_USER:?Не задан CHAT_AUTH_USER}"
: "${CHAT_AUTH_PASSWORD:?Не задан CHAT_AUTH_PASSWORD}"
: "${CHAT_WEBHOOK_URL:?Не задан CHAT_WEBHOOK_URL}"
: "${INTERNAL_API_KEY:?Не задан INTERNAL_API_KEY}"

htpasswd -bc /etc/nginx/.htpasswd \
  "$CHAT_AUTH_USER" \
  "$CHAT_AUTH_PASSWORD"
  
envsubst '${INTERNAL_API_KEY}' \
  < /etc/nginx/conf.d/default.conf.template \
  > /etc/nginx/conf.d/default.conf

envsubst '${CHAT_WEBHOOK_URL}' \
  < /usr/share/nginx/html/config.template.js \
  > /usr/share/nginx/html/config.js


exec nginx -g 'daemon off;'



