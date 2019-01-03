core:
	docker build -t nninja/grpc:latest core/

php:
	docker build -t nninja/grpc:php php/

go:
	docker build -t nninja/grpc:go go/

node:
	docker build -t nninja/grpc:node node/

all: core php go node
