#!/bin/bash

# Stolen from: https://bloggingabout.net/2026/02/19/claude-code-in-docker/

# Get current folder and parent directory info
FOLDER_NAME=$(basename "$PWD")
PARENT_DIR=$(dirname "$PWD")

CONTAINER_INTERNAL_USER="node";

# Set container name and replace '@' with '-'
CONTAINER_NAME="claude-$FOLDER_NAME"
CONTAINER_NAME="${CONTAINER_NAME//@/-}"

# Check if the container already exists (running or stopped)
if [ "$(docker ps -aq -f name=^/${CONTAINER_NAME}$)" ]; then
    echo "Container '$CONTAINER_NAME' exists. Starting/Attaching..."
    docker start -ai "$CONTAINER_NAME"
else
    # -v "$HOME/.config:/root/.config" \
    
    touch $HOME/.claude.json;

    echo "Creating new container '$CONTAINER_NAME'..."
    docker run -it \
	-u $(id -u):$(id -g) \
        --name "$CONTAINER_NAME" \
        -e HOST_WORKSPACE="$PWD" \
        -e CONTAINER_WORKDIR="/workspace/$FOLDER_NAME" \
        -v "$HOME/.claude:/home/$CONTAINER_INTERNAL_USER/.claude" \
	-v "$HOME/.claude.json:/home/$CONTAINER_INTERNAL_USER/.claude.json" \
	-v /var/run/docker.sock:/var/run/docker.sock \
        -v "$PARENT_DIR:/workspace" \
        -w "/workspace/$FOLDER_NAME" \
        claude_caged /bin/bash
fi

#EOF

