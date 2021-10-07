

debian:
	docker build --no-cache -f .docker/debian-gcc.Dockerfile -t my-gcc-app .
	docker run  my-gcc-app "./skeleton" -c dd
