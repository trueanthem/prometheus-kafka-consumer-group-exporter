COMMIT := $(shell git log --pretty=format:'%h' -n 1)
DATE := $(shell date -u +.%Y%m%d.%H%M%S)
VERSION := $(COMMIT)$(DATE)
BUILD_FLAGS := -ldflags '-w -s -X main.version=''$(VERSION)'''
PKG_NAME := github.com/kawamuray/prometheus-kafka-consumer-group-exporter/cmd/ 


all: test exporter 

exporter:
	@mkdir -p bin/
	CGO_ENABLED=0 go build $(BUILD_FLAGS) -o bin/exporter $(PKG_NAME)

exporter-linux-amd64:
	@mkdir -p bin/
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build $(BUILD_FLAGS) -o bin/exporter $(PKG_NAME)

test:
	go test $(PKG_NAME)/...

integration-test:
	go test -tags integration $(PKG_NAME)/...

.PHONY: all exporter exporter-linux-amd64 stub test web
