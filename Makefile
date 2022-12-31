new_service:
	# TODO: SERVICE_NAME validation
	cp -r ./.template/** ./$(SERVICE_NAME)
	echo "service $(SERVICE_NAME) created"

build:
	echo build

test:
	echo test

install_protoc:
	echo "install protoc-gen-go"
	go get -u github.com/golang/protobuf/protoc-gen-go

proto:
	echo "generate proto files for android/java"
	docker run --rm  -v${PWD}:${PWD} -w${PWD} jaegertracing/protobuf:latest --proto_path=${PWD}/$(SERVICE_NAME)/proto \
    	--java_out=${PWD}/$(SERVICE_NAME)/proto -I/usr/include/github.com/gogo/protobuf ${PWD}/$(SERVICE_NAME)/proto/proto.proto
	echo "generate proto files for go"
	docker run --rm  -v${PWD}:${PWD} -w${PWD} jaegertracing/protobuf:latest --proto_path=${PWD}/$(SERVICE_NAME)/proto \
		--go_out=plugins=grpc:${PWD}/$(SERVICE_NAME)/proto -I/usr/include/github.com/gogo/protobuf ${PWD}/$(SERVICE_NAME)/proto/proto.proto
	sudo chown mahmoud:mahmoud chat/proto/com/ chat/proto/proto.pb.go
deploy:
	echo "deploy services"


