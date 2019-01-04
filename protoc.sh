#!/usr/bin/env sh

PROTOBUF_REVISION=${PROTOBUF_REVISION:-"3.6.2"}
GLIBC_VERSION=${GLIBC_VERSION:-"2.23-r3"}
ALPINE_GLIBC_URL=${ALPINE_GLIBC_URL:-"https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/"}
GLIBC_PKG=${GLIBC_PKG:-"glibc-${GLIBC_VERSION}.apk"}
GLIBC_BIN_PKG=${GLIBC_BIN_PKG:-"glibc-bin-${GLIBC_VERSION}.apk"}

apk add --no-cache curl \
    && curl -sLO https://github.com/google/protobuf/releases/download/v${PROTOBUF_REVISION}/protoc-${PROTOBUF_REVISION}-linux-x86_64.zip \
    && unzip protoc-${PROTOBUF_REVISION}-linux-x86_64.zip -d /usr/local \
    && chmod +x /usr/local/bin/protoc \
    && chmod -R 755 /usr/local/include/ \
    && rm protoc-${PROTOBUF_REVISION}-linux-x86_64.zip

# libstdc++ is required for running protoc binary
apk add --update --no-cache libstdc++ \
    && rm -rf /var/cache/apk/*

# Pre-built `protoc` binary will not run on Alpine due to missing of `glibc`,
# so we need to install `glibc` first.
# Thanks to:
# - https://github.com/gliderlabs/docker-alpine/issues/11
# - https://github.com/sgerrand/alpine-pkg-glibc
# - https://github.com/sdurrheimer/alpine-glibc/blob/master/Dockerfile
# - https://github.com/stackhub/service-prometheus/blob/master/Dockerfile
#

# installing glibc and cleaning up
apk add --update --no-cache -t deps wget ca-certificates \
    && cd /tmp \
    && wget ${ALPINE_GLIBC_URL}${GLIBC_PKG} \
    && wget ${ALPINE_GLIBC_URL}${GLIBC_BIN_PKG} \
    && apk add --allow-untrusted ${GLIBC_PKG} ${GLIBC_BIN_PKG} \
    && /usr/glibc-compat/sbin/ldconfig /lib /usr/glibc-compat/lib/ \
    && echo 'hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4' >> /etc/nsswitch.conf \
    && apk del --purge deps

echo "Cleaning up"
rm -rf /tmp/* /var/cache/apk/*
