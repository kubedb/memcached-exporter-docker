SHELL=/bin/bash -o pipefail

REGISTRY   ?= kubedb
BIN        := memcached-exporter
IMAGE      := $(REGISTRY)/$(BIN)
DB_VERSION := v0.4.1
TAG        := $(shell git describe --exact-match --abbrev=0 2>/dev/null || echo "")

.PHONY: push
push: container
	docker push $(IMAGE):$(TAG)

.PHONY: container
container:
	docker pull prom/memcached-exporter:$(DB_VERSION)
	docker tag prom/memcached-exporter:$(DB_VERSION) $(IMAGE):$(TAG)

.PHONY: version
version:
	@echo ::set-output name=version::$(TAG)
