#!/bin/bash

set -e

docker login -u="$DOCKER_USERNAME" -p="$DOCKER_PASSWORD"
docker login quay.io -u="$QUAY_USERNAME" -p="$QUAY_PASSWORD"
docker build -t "$GITHUB_REPOSITORY" .
docker tag "$GITHUB_REPOSITORY" "$GITHUB_REPOSITORY:$1" "quay.io/$GITHUB_REPOSITORY" "quay.io/$GITHUB_REPOSITORY:$1"
docker push "$GITHUB_REPOSITORY"
docker push "$GITHUB_REPOSITORY:$1"
docker push "quay.io/$GITHUB_REPOSITORY"
docker push "quay.io/$GITHUB_REPOSITORY:$1"
