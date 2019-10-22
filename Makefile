DOCKER_REGISTRY ?= docker.chameleoncloud.org
DOCKER_TAG ?= $(shell git rev-parse --short HEAD)
DOCKER_IMAGE = $(DOCKER_REGISTRY)/keycloak:$(DOCKER_TAG)
DOCKER_IMAGE_DEV = $(DOCKER_REGISTRY)/keycloak:dev

.PHONY: build
build:
	docker build -t $(DOCKER_IMAGE) .
	docker tag $(DOCKER_IMAGE) $(DOCKER_IMAGE_DEV)

.PHONY: start
start:
	docker-compose up
