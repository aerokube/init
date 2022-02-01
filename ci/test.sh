#!/bin/bash

export GO111MODULE="on"
go test -v -race ./...
