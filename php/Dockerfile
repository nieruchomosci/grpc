FROM php:7-cli-alpine

COPY --from=nninja/grpc:latest /usr/local/bin/grpc_php_plugin /usr/local/bin/grpc_php_plugin

COPY protoc.sh /usr/local/bin/protoc.sh

RUN sh /usr/local/bin/protoc.sh

ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME=/opt/composer/
ENV PATH /opt/composer/bin:$PATH

COPY --from=composer:1.8 /usr/bin/composer /usr/bin/composer
