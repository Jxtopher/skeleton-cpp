PROJECT=skeleton-cpp

dev:
	docker build -f .docker/dev.Dockerfile -t $(PROJECT)-dev .
	docker run -it --rm --name skeleton-dev --mount type=bind,source="$$PWD"/.,target=/app $(PROJECT)-dev

prod:
	docker build -f .docker/debian-gcc.Dockerfile -t $(PROJECT)-prod .
	docker run $(PROJECT)-debian-gcc "./skeleton" -c test.conf
debian-gcc:
	docker build --no-cache -f .docker/debian-gcc.Dockerfile -t $(PROJECT)-debian-gcc .
	docker run  $(PROJECT)-debian-gcc "./skeleton" -c test.conf
	docker run  $(PROJECT)-debian-gcc "ctest"
