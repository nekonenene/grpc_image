FROM grpc_base:latest

WORKDIR ${GOPATH}/src/nekonenene/hello

ADD src .
RUN dep ensure

CMD ["go", "run", "main.go"]
