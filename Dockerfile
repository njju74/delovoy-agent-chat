FROM nginx:alpine

RUN apk add --no-cache apache2-utils gettext

COPY nginx.conf.template /etc/nginx/conf.d/default.conf.template
COPY . /usr/share/nginx/html/
COPY memory.html /usr/share/nginx/html/memory.html
COPY config.template.js /usr/share/nginx/html/config.template.js
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

EXPOSE 80

ENTRYPOINT ["/entrypoint.sh"]
