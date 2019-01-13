# Docker gRPC & ProtoBuf toolset

The repository contains docker images to generate gRPC client/server definitions and ProtoBuf messages.

> All images are based on the alpine dist.

## Tags 
* `latest` - tag is a large image that contains all compiled plugins binaries
* `php` - is based on `php:7-cli-alpine` image and includes only necessary libs and binaries. It's much smaller than `latest` version.
* `node` - is based on `node:11` image and includes [grpc-tools](https://www.npmjs.com/package/grpc-tools) and [protobuf.js](https://dcode.io/protobuf.js/)
* `go` - is based on `golang:1-alpine` image and includes:
  * `github.com/golang/protobuf/{protoc-gen-go,proto}`
  * `google.golang.org/grpc`

More details can be found under apropriate subfolders.

## Available binaries (plugins)

* `/usr/local/bin/grpc_cpp_plugin`
* `/usr/local/bin/grpc_csharp_plugin`
* `/usr/local/bin/grpc_node_plugin`
* `/usr/local/bin/grpc_objective_c_plugin`
* `/usr/local/bin/grpc_php_plugin`
* `/usr/local/bin/grpc_python_plugin`
* `/usr/local/bin/grpc_ruby_plugin`
 
The simplest way to use them is coping a binary file from the external image e.g.

```Dockerfile
COPY --from=nninja/grpc:latest /usr/local/bin/grpc_php_plugin /usr/local/bin/grpc_php_plugin
``` 

# gRPC & protoc

In order to generate gRPC stubs and protobuf messages for the specific language you can use the images provided by this repository.

A gRPC sample service can be found under `examples` directories. 
To generate service definition and protobuf messages just run `./generate.sh`. An output can be found under `examples/output`

# Contributing

Any help and PRs are kindly welcome. Do not hestitate to report the issue or just send me a feedback.
Please follow by common contributing flow called `github flow`.

### Links 

* https://github.com/protocolbuffers/protobuf/
* https://github.com/grpc/grpc/
* https://hub.docker.com/r/gnhuy91/protobuf/dockerfile/
* https://github.com/znly/docker-protobuf/
* https://hub.docker.com/r/znly/protoc/
