FROM alpine:3.8

ARG S6_OVERLAY_VER=1.21.7.0

RUN apk add --no-cache curl ca-certificates shadow gnupg bash gomplate \
  && rm -rf /var/cache/apk/* \
  && curl -L -s "https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VER}/s6-overlay-amd64.tar.gz" \
   | tar xvzf - -C / \
  && curl -L -s "https://caddyserver.com/download/linux/amd64?license=personal&telemetry=off" \
   | tar xvzf - caddy -C /bin \
  && sed -i 's/^CREATE_MAIL_SPOOL=yes/CREATE_MAIL_SPOOL=no/' /etc/default/useradd \
  && groupmod -g 1000 users \
  && useradd -u 911 -U -d /config -s /bin/false relicabackup \
  && usermod -G users relicabackup \
  && mkdir -p /backup /config /opt

COPY rootfs /

EXPOSE 1201/tcp 1301/tcp
VOLUME /backup /config

ENTRYPOINT ["/init"]
