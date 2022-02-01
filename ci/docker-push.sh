#!/bin/bash

set -e

docker login -u="$DOCKER_USERNAME" -p="$DOCKER_PASSWORD"
docker build -t "$GITHUB_REPOSITORY" .
docker tag "$GITHUB_REPOSITORY" "$GITHUB_REPOSITORY:$1"
docker push "$GITHUB_REPOSITORY"
docker push "$GITHUB_REPOSITORY:$1"