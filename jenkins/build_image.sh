#!/bin/bash
set -euo pipefail

IMAGE="ghcr.io/pie-12/devops-linux-final/app"
TAG="git-$(git rev-parse --short HEAD)"

echo "--- Building and tagging image: $IMAGE:$TAG and $IMAGE:main ---"
docker build -t "$IMAGE:$TAG" -t "$IMAGE:main" ./app

echo "--- Pushing images to GHCR ---"
docker push "$IMAGE:$TAG"
docker push "$IMAGE:main"

echo "--- Writing image SHA to jenkins/image.env ---"
echo "IMAGE_SHA=$IMAGE:$TAG" > jenkins/image.env

echo "--- Done ---"