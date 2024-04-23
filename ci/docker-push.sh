#!/bin/bash

set -e

docker login -u="$DOCKER_USERNAME" -p="$DOCKER_PASSWORD"
docker login quay.io -u="$QUAY_USERNAME" -p="$QUAY_PASSWORD"

docker buildx build --platform linux/amd64,linux/arm64 --provenance false --push \
  -t $GITHUB_REPOSITORY -t $GITHUB_REPOSITORY:$1 \
  -t quay.io/$GITHUB_REPOSITORY -t quay.io/$GITHUB_REPOSITORY:$1 \
  .
