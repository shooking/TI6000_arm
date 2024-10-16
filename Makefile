SHELL:=/bin/bash

# Current date
CURRENT_DATE = $(shell date -u +"%Y-%m-%d")

# Project name
PROJECT := ti6000-docker

# Version from file
VERSION := $(shell cat version.txt)

# The docker tag name
DOCKER_TAG_NAME = latest

# Docker account
DOCKER_ACCOUNT = shookingsybase

ARCH = $(shell arch)
# Docker image name
DOCKER_IMAGE_NAME = $(PROJECT)-${ARCH}

# Docker Hub credentials
DOCKER_USERNAME = ${DOCKERHUB_USERNAME}
DOCKER_PASSWORD = ${DOCKERHUB_PASSWORD}
## Run ci part
.PHONY: all
all: clean build

## Clean docker image
.PHONY: clean
clean:
	-docker rmi $(DOCKER_ACCOUNT)/$(DOCKER_IMAGE_NAME):$(VERSION)
	-docker rmi $(DOCKER_ACCOUNT)/$(DOCKER_IMAGE_NAME):latest

## Build docker image
.PHONY: build
build:
	docker build -f Dockerfile -t $(DOCKER_ACCOUNT)/$(DOCKER_IMAGE_NAME):$(DOCKER_TAG_NAME) .
	chmod +x install_ticmd.sh
	. ./install_ticmd.sh
	chmod +x ticmd.sh

## Tag docker images
.PHONY: tag-images
tag-images:
	docker tag "${DOCKER_ACCOUNT}/${DOCKER_IMAGE_NAME}:$(DOCKER_TAG_NAME)" "${DOCKER_ACCOUNT}/${DOCKER_IMAGE_NAME}:${VERSION}"
	docker tag "${DOCKER_ACCOUNT}/${DOCKER_IMAGE_NAME}:$(DOCKER_TAG_NAME)" "${DOCKER_ACCOUNT}/${DOCKER_IMAGE_NAME}:${VERSION}-${CURRENT_DATE}"

## Publish docker image
.PHONY: publish
publish: build tag-images
	echo "${DOCKER_PASSWORD}" | docker login -u "${DOCKER_USERNAME}" --password-stdin
	docker push "${DOCKER_ACCOUNT}/${DOCKER_IMAGE_NAME}:${VERSION}"
