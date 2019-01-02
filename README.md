# Docker gRPC & ProtoBuf toolset

The repository contains docker images to generate gRPC client/server definitions and ProtoBuf messages.

> All images are based on the alpine dist.

`latest` - tag is a large image that contains all compiled plugins binaries
`php` - is based on `php:7-cli-alpine` image and includes only necessary libs and binaries. It's much smaller than `latest` version.
 
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

# Contributing

Any help and PRs are kindly welcome. Do not hestitate to report the issue or just send me a feedback.
Please follow by common contributing flow called `github flow`.

### Links 

* https://github.com/protocolbuffers/protobuf/
* https://github.com/grpc/grpc/
* https://hub.docker.com/r/gnhuy91/protobuf/dockerfile/
* https://github.com/znly/docker-protobuf/
* https://hub.docker.com/r/znly/protoc/
