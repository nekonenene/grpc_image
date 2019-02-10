FROM golang:latest

# Ref: https://github.com/protocolbuffers/protobuf/releases
ARG protoc_version=3.6.1

WORKDIR /home/grpc

# Official grpc repositories
RUN go get -u google.golang.org/grpc
RUN go get -u github.com/golang/protobuf/protoc-gen-go

# Support tools for development
RUN go get -u github.com/golang/dep/cmd/dep
RUN go get -u github.com/fullstorydev/grpcurl/cmd/grpcurl

RUN echo "alias ls='ls --color=auto'" >> $HOME/.bashrc

RUN \
  apt-get update && \
  apt-get install -y \
    less \
    unzip \
    vim \
    wget

# Install protoc
RUN \
  wget https://github.com/protocolbuffers/protobuf/releases/download/v${protoc_version}/protoc-${protoc_version}-$(uname -s)-$(uname -m).zip && \
  unzip protoc-${protoc_version}-$(uname -s)-$(uname -m).zip -d /usr/local

CMD ["/bin/bash"]
