new_service:
	# TODO: SERVICE_NAME validation
	cp -r ./.template ./$(SERVICE_NAME)
	echo "service $(SERVICE_NAME) created"

build:
	echo build

test:
	echo test

proto:
	echo "generate proto for specific service"

deploy:
	echo "deploy services"


