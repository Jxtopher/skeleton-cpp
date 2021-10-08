

debian:
	docker build --no-cache -f .docker/debian-gcc.Dockerfile -t skeleton-cpp-debian-gcc .
	docker run  skeleton-cpp-debian-gcc "build/skeleton" -c dd
