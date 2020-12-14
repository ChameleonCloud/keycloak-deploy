DOCKER_REGISTRY ?= docker.chameleoncloud.org

KEYCLOAK_VERSION ?= 10.0.1
# Take the major version from Keycloak version
SERVER_TAG ?= $(word 1,$(subst ., ,$(KEYCLOAK_VERSION)))
SERVER_IMAGE = $(DOCKER_REGISTRY)/keycloak:$(SERVER_TAG)
SERVER_IMAGE_DEV = $(DOCKER_REGISTRY)/keycloak:dev

MARIADB_VERSION ?= 10.3
DB_TAG ?= $(MARIADB_VERSION)
DB_IMAGE = $(DOCKER_REGISTRY)/keycloak-db:$(DB_TAG)
DB_IMAGE_DEV = $(DOCKER_REGISTRY)/keycloak-db:dev

.PHONY: build
build:
	docker build -t $(SERVER_IMAGE) --build-arg KEYCLOAK_VERSION=$(KEYCLOAK_VERSION) .
	docker tag $(SERVER_IMAGE) $(SERVER_IMAGE_DEV)
	docker build -f Dockerfile.db -t $(DB_IMAGE) --build-arg MARIADB_VERSION=$(MARIADB_VERSION) .
	docker tag $(DB_IMAGE) $(DB_IMAGE_DEV)

.PHONY: publish
publish:
	docker push $(SERVER_IMAGE)
	docker push $(DB_IMAGE)

.PHONY: start
start:
	docker-compose up
