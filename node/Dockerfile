FROM node:11-alpine

RUN npm install -g grpc-tools --unsafe-perm=true --allow-root && \
    npm install -g protobufjs --unsafe-perm=true --allow-root && \
    npm install -g grpc_tools_node_protoc_ts --unsafe-perm=true --allow-root

ENV PATH "$PATH:/root/.npm/bin/"

COPY protoc.sh /usr/local/bin/protoc.sh

RUN sh /usr/local/bin/protoc.sh
