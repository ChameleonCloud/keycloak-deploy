DOCKER_REGISTRY ?= docker.chameleoncloud.org
DOCKER_IMAGE = $(DOCKER_REGISTRY)/keycloak:$(DOCKER_TAG)
DOCKER_IMAGE_DEV = $(DOCKER_REGISTRY)/keycloak:dev

KEYCLOAK_VERSION ?= 10.0.1
# Take the major version from Keycloak version
DOCKER_TAG ?= $(word 1,$(subst ., ,$(KEYCLOAK_VERSION)))

.PHONY: build
build:
	docker build -t $(DOCKER_IMAGE) --build-arg KEYCLOAK_VERSION=$(KEYCLOAK_VERSION) .
	docker tag $(DOCKER_IMAGE) $(DOCKER_IMAGE_DEV)

.PHONY: publish
publish:
	docker push $(DOCKER_IMAGE)

.PHONY: start
start:
	docker-compose up
