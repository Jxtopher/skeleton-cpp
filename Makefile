
all:

debian-gcc:
	docker build --no-cache -f .docker/debian-gcc.Dockerfile -t skeleton-cpp-debian-gcc .
	docker run  skeleton-cpp-debian-gcc "./skeleton" -c dd
	docker run  skeleton-cpp-debian-gcc "ctest"