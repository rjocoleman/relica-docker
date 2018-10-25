FROM alpine:3.8

RUN apk add --no-cache curl ca-certificates \
  && curl -L -s https://github.com/just-containers/s6-overlay/releases/download/v1.21.7.0/s6-overlay-amd64.tar.gz \
   | tar xvzf - -C / \
  && apk del --no-cache curl \
  && rm -rf /var/cache/apk/*

COPY rootfs /
COPY Caddyfile /etc/

ADD https://caddyserver.com/download/linux/amd64?license=personal&telemetry=off /tmp/caddy.tar.gz

RUN tar -xzf /tmp/caddy.tar.gz -C "/bin" \
  && rm /tmp/caddy.tar.gz

EXPOSE 1301

ARG relica_os=linux
ARG relica_arch=amd64
ARG relica_ver=1.0.0-rc2

ADD https://relica-releases.s3.wasabisys.com/dist/v${relica_ver}/relica_v${relica_ver}_${relica_os}_${relica_arch}.tar.gz /tmp/relica.tar.gz

RUN mkdir /opt \
  && tar -xzf /tmp/relica.tar.gz -C "/opt" \
  && chown -R $(id -u):$(id -g) /opt/relica \
  && rm /tmp/relica.tar.gz

ENV PATH=$PATH:/opt/relica/bin

## TODO check this out to see if there is a smater way to do this or if we need to bring in our own config file
RUN sed -i '/^upgrade_policy = /{h;s/ = .*/ = "disabled"/};${x;/^$/{s//upgrade_policy = "disabled"/;H};x}' /opt/relica/config.toml

EXPOSE 1201
VOLUME /root/.relica

ENTRYPOINT ["/init"]
