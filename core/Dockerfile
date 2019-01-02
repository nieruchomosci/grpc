FROM alpine as builder

RUN apk add --update \
    autoconf \
    automake \
    build-base\
    curl \
    git \
    libtool \
    unzip \
    bash \
    libstdc++ \
    && rm -rf /var/cache/apk/*

RUN git clone --depth 1 --recursive -b $(curl -L https://grpc.io/release) https://github.com/grpc/grpc /grpc

RUN cd /grpc/ \
    && make \
    && mv ./bins/opt/* /usr/local/bin/ \
    && rm -rf /grpc/

# Protobuf version
ENV PROTOBUF_REVISION 3.6.1
ENV PROTOBUF_DISTRIBUTION linux-x86_64
ENV PROTOBUF_URL https://github.com/protocolbuffers/protobuf/releases/download/v${PROTOBUF_REVISION}/protoc-${PROTOBUF_REVISION}-${PROTOBUF_DISTRIBUTION}.zip
ENV PROTOBUF_ZIP protoc-${PROTOBUF_REVISION}-${PROTOBUF_DISTRIBUTION}.zip
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
    # install protobuf
    && wget ${PROTOBUF_URL} \
    && unzip ${PROTOBUF_ZIP} 'bin/*' -d /usr/local/ \
    # Cleanup
    && apk del --purge deps \
    && rm -rf /tmp/* /var/cache/apk/*

ENTRYPOINT ["protoc"]
