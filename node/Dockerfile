FROM node:11

RUN npm install -g grpc-tools --unsafe-perm=true --allow-root && \
    npm install -g protobufjs --unsafe-perm=true --allow-root

ENV PATH "$PATH:/root/.npm/bin/"
