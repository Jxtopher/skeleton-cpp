dev:
	docker build -f .docker/debian-gcc.Dockerfile -t skeleton-dev .
	docker run -it --rm --name skeleton-dev --mount type=bind,source="$(pwd)"/.,target=/app skeleton-dev

debian-gcc:
	docker build --no-cache -f .docker/debian-gcc.Dockerfile -t skeleton-cpp-debian-gcc .
	docker run  skeleton-cpp-debian-gcc "./skeleton" -c dd
	docker run  skeleton-cpp-debian-gcc "ctest"
