# Ref: https://github.com/protocolbuffers/protobuf/releases
PROTOC_VER := 3.6.1

BASE_CONTAINER_NAME := grpc_base_01
HELLO_CONTAINER_NAME := grpc_hello_01
LISTEN_PORT := 50051

go_path := $(shell echo "${GOPATH}" | awk -F '[:]' '{print ${1}}')

.PHONY: init
init:
	mkdir -p $(go_path)/src/nekonenene/hello
	ln -sf $(shell pwd)/hello/src/pb $(go_path)/src/nekonenene/hello/pb

.PHONY: build
build:
	$(MAKE) build_base
	$(MAKE) build_hello

.PHONY: run
run: run_hello

.PHONY: build_base
build_base:
	docker build base \
		--build-arg protoc_version=$(PROTOC_VER) \
		-t grpc_base:$(PROTOC_VER) \
		-t grpc_base:latest

.PHONY: build_hello
build_hello:
	docker build hello \
		-t grpc_hello:latest

.PHONY: run_hello
run_hello:
	docker run -it --rm --name $(HELLO_CONTAINER_NAME) \
		-p $(LISTEN_PORT):50051 \
		grpc_hello:latest

# Update hello.pb.go
.PHONY: pb_hello
pb_hello:
	docker run --rm --name $(BASE_CONTAINER_NAME) \
		-v $(shell pwd)/hello/src/pb:/tmp/pb \
		grpc_hello:latest \
		protoc pb/hello.proto --go_out plugins=grpc:/tmp

.PHONY: login_base
login_base:
	docker run -it --rm --name $(BASE_CONTAINER_NAME) \
		-p $(LISTEN_PORT):50051 \
		grpc_base:latest \
		/bin/bash

.PHONY: login_hello
login_hello:
	docker run -it --rm --name $(HELLO_CONTAINER_NAME) \
		-p $(LISTEN_PORT):50051 \
		grpc_hello:latest \
		/bin/bash
