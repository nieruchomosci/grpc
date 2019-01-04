core:
	docker build -t nninja/grpc:latest -f ./core/Dockerfile .

php:
	docker build -t nninja/grpc:php -f ./php/Dockerfile .

go:
	docker build -t nninja/grpc:go -f ./go/Dockerfile .

node:
	docker build -t nninja/grpc:node -f ./node/Dockerfile .

web:
	docker build -t nninja/grpc:web -f ./web/Dockerfile .

all: core php go node web
