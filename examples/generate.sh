#!/usr/bin/env bash

set -e

echo -e "Generating Improbable gRPC-web..."
output="./output/web-improbable"
mkdir -p ${output}
docker run -it --rm -v $PWD:/app -w /app nninja/grpc:web \
        protoc -I=. \
        --js_out="import_style=commonjs:${output}" \
        --ts_out="service=true:${output}" \
        sample.proto

echo -e "Generating gRPC-web..."
output="./output/web-grpc"
mkdir -p ${output}
docker run -it --rm -v $PWD:/app -w /app nninja/grpc:web \
        protoc -I=. \
        --js_out="import_style=commonjs:${output}" \
        --grpc-web_out="import_style=commonjs+dts,mode=grpcwebtext:${output}" \
        sample.proto

echo -e "Generating gRPC PHP ..."
output="./output/php"
mkdir -p ${output}
docker run -it --rm -v $PWD:/app -w /app nninja/grpc:php \
        protoc -I=. \
        --php_out="plugins=grpc:${output}" \
        --grpc_out="${output}" \
        --plugin=protoc-gen-grpc=/usr/local/bin/grpc_php_plugin \
        sample.proto

echo -e "Generating gRPC node ..."
output="./output/node"
mkdir -p ${output}
docker run -it --rm -v $PWD:/app -w /app nninja/grpc:node \
        pbjs -t static-module \
        -w "commonjs" \
        -o "${output}/compiled.js" \
        sample.proto
docker run -it --rm -v $PWD:/app -w /app nninja/grpc:node \
        pbts -o "${output}/compiled.d.ts" "${output}/compiled.js" \
        sample.proto

echo -e "Generating gRPC go ..."
output="./output/go"
mkdir -p ${output}
docker run -it --rm -v $PWD:/app -w /app nninja/grpc:go \
        protoc -I. \
        --go_out="plugins=grpc:${output}" \
        --plugin=protoc-gen-grpc=protoc-gen-go \
        sample.proto

echo -e "Generating gRPC documentation ..."
output="./output/doc"
mkdir -p ${output}
docker run -it --rm -v $PWD:/app -w /app nninja/grpc:go \
        protoc -I. \
        --plugin=/usr/local/bin/protoc-gen-doc \
        --doc_out="${output}" \
        sample.proto

