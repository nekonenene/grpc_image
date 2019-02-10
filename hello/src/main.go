package main

import (
	"context"
	"flag"
	"fmt"
	"log"
	"net"
	"path/filepath"

	pb "nekonenene/hello/pb"

	"google.golang.org/grpc"
	"google.golang.org/grpc/credentials"
	"google.golang.org/grpc/reflection"
)

var (
	tls      *bool   = flag.Bool("tls", false, "Connection uses TLS if true, else plain TCP")
	certFile *string = flag.String("cert_file", "", "The TLS cert file")
	keyFile  *string = flag.String("key_file", "", "The TLS key file")
)

const (
	port = 50051
)

// server is used to implement hello.GreeterServer.
type server struct{}

// SayHello implements hello.GreeterServer
func (s *server) SayHello(ctx context.Context, in *pb.HelloRequest) (*pb.HelloReply, error) {
	log.Printf("Received: %v, %v", in.Name, in.Age)
	return &pb.HelloReply{Message: fmt.Sprintf("%s is %d years old.", in.Name, in.Age)}, nil
}

func main() {
	lis, err := net.Listen("tcp", fmt.Sprintf(":%d", port))
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}

	var opts []grpc.ServerOption
	flag.Parse()
	if *tls {
		if *certFile == "" || *keyFile == "" {
			log.Fatalf("Please specify cert_file and key_file.")
		}
		*certFile, _ = filepath.Abs(*certFile)
		*keyFile, _ = filepath.Abs(*keyFile)

		creds, err := credentials.NewServerTLSFromFile(*certFile, *keyFile)
		if err != nil {
			log.Fatalf("Failed to generate credentials %v", err)
		}
		log.Println("Generated credentials")
		opts = []grpc.ServerOption{grpc.Creds(creds)}
	}

	grpcServer := grpc.NewServer(opts...)
	pb.RegisterGreeterServer(grpcServer, &server{})
	log.Printf("Server started at localhost:%d\n", port)

	// Register reflection service on gRPC server.
	reflection.Register(grpcServer)

	if err := grpcServer.Serve(lis); err != nil {
		log.Fatalf("failed to serve: %v", err)
	}
}
