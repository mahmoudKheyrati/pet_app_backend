package examples

import (
	context "context"
	"github.com/mahmoudKheyrati/pet_app_backend/chat/proto"
	"google.golang.org/grpc"
	"log"
	"net"
)

type GreaterService struct {
	proto.UnimplementedGreaterServer
}

func (g *GreaterService) SayHello(ctx context.Context, request *proto.HelloRequest) (*proto.HelloReply, error) {
	log.Println(request.Name)
	return &proto.HelloReply{Message: "Hello " + request.Name}, nil
}

func GrpcServerExample() {
	// grpc example
	listen, err := net.Listen("tcp", ":8050")
	if err != nil {
		panic(err)
	}
	defer func(listen net.Listener) {
		err := listen.Close()
		if err != nil {
			panic(err)
		}
	}(listen)

	// creating grpc server
	grpcServer := grpc.NewServer()
	// registering our service
	service := GreaterService{}
	proto.RegisterGreaterServer(grpcServer, &service)

	// starting grpc server
	err = grpcServer.Serve(listen)
	if err != nil {
		panic(err)
	}
}
