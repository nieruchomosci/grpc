FROM php:7-cli-alpine

COPY --from=nninja/grpc:latest /grpc/bins/opt/grpc_php_plugin /usr/local/bin/grpc_php_plugin
COPY --from=nninja/grpc:latest /usr/local/bin/protoc /usr/local/bin/protoc

# libstdc++ is required for running protoc binary
RUN apk add --update --no-cache libstdc++ \
    && rm -rf /var/cache/apk/*
