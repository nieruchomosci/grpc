.DEFAULT: all

.PHONY: php
core:
	docker build -t nninja/grpc:latest -f ./core/Dockerfile .

.PHONY: php
php:
	docker build -t nninja/grpc:php -f ./php/Dockerfile .

.PHONY: go
go:
	docker build -t nninja/grpc:go -f ./go/Dockerfile .

.PHONY: node
node:
	docker build -t nninja/grpc:node -f ./node/Dockerfile .

.PHONY: web
web:
	docker build -t nninja/grpc:web -f ./web/Dockerfile .

.PHONY: all
all: core php go node web
