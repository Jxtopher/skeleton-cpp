.PHONY: dev run debian-gcc
PROJECT_NAME=skeleton-cpp

dev:
	docker build -f .devcontainer/Dockerfile -t ${PROJECT_NAME}-dev .
	docker run -it --rm --name ${PROJECT_NAME}-dev --mount type=bind,source="$$PWD"/.,target=/app $(PROJECT_NAME)-dev

run:
	docker build -f .docker/debian-gcc.Dockerfile -t ${PROJECT_NAME}-prod .
	docker run ${PROJECT_NAME}-debian-gcc "./skeleton" -c test.conf

debian-gcc:
	docker build --no-cache -f .docker/debian-gcc.Dockerfile -t ${PROJECT_NAME}-debian-gcc .
	docker run  ${PROJECT_NAME}-debian-gcc "./skeleton" -c test.conf
	docker run  ${PROJECT_NAME}-debian-gcc "ctest"
