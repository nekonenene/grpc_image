# Ref: https://github.com/protocolbuffers/protobuf/releases
PROTOC_VER := 3.6.1

BASE_CONTAINER_NAME := grpc_base_01
LISTEN_PORT := 50051

.PHONY: build_base
build_base:
	docker build base \
		--build-arg protoc_version=$(PROTOC_VER) \
		-t grpc_base:latest

.PHONY: run_base
run_base:
	docker run -it --rm --name $(BASE_CONTAINER_NAME) \
		-p $(LISTEN_PORT):50051 \
		grpc_base:latest
