FROM alpine:latest
LABEL Name=openvpn-client Version=0.1
LABEL maintainer="Chris Campbell"

RUN apk --no-cache --no-progress update && apk --no-cache --no-progress upgrade \
    && apk --no-cache --no-progress add bash curl jq openvpn shadow tini speedtest-cli \
    && rm -rf /tmp/* /var/tmp/*

COPY openvpn_start.sh /usr/bin
RUN ["chmod", "+x", "/usr/bin/openvpn_start.sh"]

ENV CONFIG_PATH="/config" \
    OPENVPN_CONF=NONE \
    OPENVPN_AUTH=NONE \
    OPENVPN_OPTS=

VOLUME ["/config"]
ENTRYPOINT ["tini", "--", "/usr/bin/openvpn_start.sh"]
