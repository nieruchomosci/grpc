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

ENTRYPOINT ["protoc"]
