FROM node:11-alpine

RUN npm install -g --unsafe-perm=true --allow-root \
    ts-protoc-gen@0.9.0 \
    google-protobuf

ENV PATH "$PATH:/root/.npm/bin/"

COPY protoc.sh /usr/local/bin/protoc.sh

RUN sh /usr/local/bin/protoc.sh

ENV GRPC_WEB_VERSION 1.0.3
RUN apk add --no-cache curl \
    && curl -sL https://github.com/grpc/grpc-web/releases/download/${GRPC_WEB_VERSION}/protoc-gen-grpc-web-${GRPC_WEB_VERSION}-linux-x86_64 \
    -o /usr/local/bin/protoc-gen-grpc-web \
    && chmod +x /usr/local/bin/protoc-gen-grpc-web
