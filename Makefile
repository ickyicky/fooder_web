VERSION=0.`git rev-list --count HEAD`
.PHONY: black

DOCKER_BUILD=docker build

ifeq ($(shell uname -m), arm64)
DOCKER_BUILD=docker buildx build --platform linux/amd64
endif

.PHONY: build
build:
	flutter build web
	$(DOCKER_BUILD) -t registry.domandoman.xyz/fooder/app -f Dockerfile .

.PHONY: push
push:
	docker push registry.domandoman.xyz/fooder/app
