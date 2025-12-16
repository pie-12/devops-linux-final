#!/bin/bash
set -euo pipefail

WEB_HOST="10.76.221.92"
WEB_USER="duck"
CONTAINER_NAME="demo-app"
HOST_PORT="8080"
CONTAINER_PORT="3000"
IMAGE_REPO="ghcr.io/pie-12/devops-linux-final/app"

# Default to 'main' tag, but use specific SHA from build stage if available
IMAGE_TO_DEPLOY="$IMAGE_REPO:main"
if [ -f "jenkins/image.env" ]; then
    source jenkins/image.env
    IMAGE_TO_DEPLOY="$IMAGE_SHA"
fi

echo "--- Deploying image: $IMAGE_TO_DEPLOY to $WEB_HOST ---"

# Using heredoc to execute a script on the remote host
ssh -o StrictHostKeyChecking=accept-new -o ConnectTimeout=10 "${WEB_USER}@${WEB_HOST}" << EOF
    set -ex
    
    echo "--- Pulling latest image on VM2 ---"
    docker pull "$IMAGE_TO_DEPLOY"
    
    # Check if container exists and stop/remove it
    if [ \$(docker ps -q -f name=^/${CONTAINER_NAME}$) ]; then
        echo "--- Stopping and removing existing container: $CONTAINER_NAME ---"
        docker stop "$CONTAINER_NAME"
        docker rm "$CONTAINER_NAME"
    fi
    
    echo "--- Starting new container: $CONTAINER_NAME ---"
    docker run -d \\
        --name "$CONTAINER_NAME" \\
        -p "${HOST_PORT}:${CONTAINER_PORT}" \\
        --restart unless-stopped \\
        "$IMAGE_TO_DEPLOY"
        
    echo "--- Verifying deployment on VM2 ---"
    docker ps -f name="$CONTAINER_NAME"
EOF

echo "--- Deployment script finished ---"