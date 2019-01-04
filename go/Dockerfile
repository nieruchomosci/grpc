FROM golang:1-alpine

RUN apk --update add git

# A Protocol Buffer version
ARG PROTO_TAG=v1.2.0

# A gRPC library version.
ARG GRPC_TAG=v1.17.0

RUN go get github.com/golang/protobuf/protoc-gen-go \
    && git -C "$(go env GOPATH)"/src/github.com/golang/protobuf checkout $PROTO_TAG \
    && go install github.com/golang/protobuf/protoc-gen-go \
    && go get google.golang.org/grpc \
    && git -C "$(go env GOPATH)"/src/google.golang.org/grpc checkout $GRPC_TAG

ENV PATH $PATH:$GOPATH/bin:/usr/local/bin

COPY protoc.sh /usr/local/bin/protoc.sh

RUN sh /usr/local/bin/protoc.sh
