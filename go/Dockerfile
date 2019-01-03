FROM golang:1-alpine

RUN apk --update add git

RUN go get -u github.com/golang/protobuf/protoc-gen-go \
    && go get -u github.com/golang/protobuf/proto \
    && go get -u google.golang.org/grpc

ENV PATH $PATH:$GOPATH/bin:/usr/local/bin

COPY protoc.sh /usr/local/bin/protoc.sh

RUN sh /usr/local/bin/protoc.sh
