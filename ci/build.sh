#!/bin/bash

set -e

GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -ldflags "-s -w" -o init-amd64
GOOS=linux GOARCH=arm64 CGO_ENABLED=0 go build -ldflags "-s -w" -o init-arm64
