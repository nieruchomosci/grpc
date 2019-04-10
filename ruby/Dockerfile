FROM ruby:2-alpine

RUN gem install grpc grpc-tools

COPY protoc.sh /usr/local/bin/protoc.sh

RUN sh /usr/local/bin/protoc.sh
