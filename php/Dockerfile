FROM php:7-cli-alpine

COPY --from=nninja/grpc:latest /usr/local/bin/grpc_php_plugin /usr/local/bin/grpc_php_plugin
COPY --from=nninja/grpc:latest /usr/local/bin/protoc /usr/local/bin/protoc

# libstdc++ is required for running protoc binary
RUN apk add --update --no-cache libstdc++ \
    && rm -rf /var/cache/apk/*

#
# Pre-built `protoc` binary will not run on Alpine due to missing of `glibc`,
# so we need to install `glibc` first.
# Thanks to:
# - https://github.com/gliderlabs/docker-alpine/issues/11
# - https://github.com/sgerrand/alpine-pkg-glibc
# - https://github.com/sdurrheimer/alpine-glibc/blob/master/Dockerfile
# - https://github.com/stackhub/service-prometheus/blob/master/Dockerfile
#
ENV GLIBC_VERSION="2.23-r3"
ENV ALPINE_GLIBC_URL=https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/
ENV GLIBC_PKG=glibc-${GLIBC_VERSION}.apk
ENV GLIBC_BIN_PKG=glibc-bin-${GLIBC_VERSION}.apk

RUN apk add --update --no-cache -t deps wget ca-certificates \
    && cd /tmp \
    # install glibc
     && wget ${ALPINE_GLIBC_URL}${GLIBC_PKG} \
    && wget ${ALPINE_GLIBC_URL}${GLIBC_BIN_PKG} \
    && apk add --allow-untrusted ${GLIBC_PKG} ${GLIBC_BIN_PKG} \
    && /usr/glibc-compat/sbin/ldconfig /lib /usr/glibc-compat/lib/ \
    && echo 'hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4' >> /etc/nsswitch.conf \
    # Cleanup
    && apk del --purge deps \
    && rm -rf /tmp/* /var/cache/apk/*
