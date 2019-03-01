FROM golang:1-alpine as doc-builder

RUN apk add --no-cache build-base curl automake autoconf libtool git zlib-dev

ARG PROTOC_GEN_DOC_VERSION=1.1.0
RUN mkdir -p ${GOPATH}/src/github.com/pseudomuto/protoc-gen-doc \
    && curl -L https://github.com/pseudomuto/protoc-gen-doc/archive/v${PROTOC_GEN_DOC_VERSION}.tar.gz | tar xvz --strip 1 -C ${GOPATH}/src/github.com/pseudomuto/protoc-gen-doc

RUN cd ${GOPATH}/src/github.com/pseudomuto/protoc-gen-doc \
        && make build \
        && install -c ${GOPATH}/src/github.com/pseudomuto/protoc-gen-doc/protoc-gen-doc /usr/local/bin/

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

RUN go get github.com/nieruchomosci/protoc-gen-gotag \
    && go install github.com/nieruchomosci/protoc-gen-gotag \
    && go build github.com/nieruchomosci/protoc-gen-gotag \
    && chmod +x protoc-gen-gotag \
    && mv protoc-gen-gotag /usr/local/bin/protoc-gen-gotag

ENV PATH $PATH:$GOPATH/bin:/usr/local/bin

COPY protoc.sh /usr/local/bin/protoc.sh

RUN sh /usr/local/bin/protoc.sh

COPY --from=doc-builder /usr/local/bin/protoc-gen-doc /usr/local/bin/protoc-gen-doc
