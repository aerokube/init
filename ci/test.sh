#!/bin/bash

export GO111MODULE="on"
go test -v -race ./...

go install golang.org/x/vuln/cmd/govulncheck@latest
"$(go env GOPATH)"/bin/govulncheck ./...
