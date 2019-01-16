FROM node:11-alpine

RUN npm install -g grpc-tools --unsafe-perm=true --allow-root \
    && npm install -g ts-protoc-gen --unsafe-perm=true --allow-root

COPY --from=nninja/grpc:latest /usr/local/bin/grpc_node_plugin /usr/local/bin/grpc_node_plugin

COPY protoc.sh /usr/local/bin/protoc.sh

RUN sh /usr/local/bin/protoc.sh

ENV PATH "$PATH:/root/.npm/bin/"
