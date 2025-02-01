#!/bin/bash

# Build the docker command with or without NEKO_PASSWORD depending on its value
docker_cmd="docker run -d --name neko-container \
  --cap-add=SYS_ADMIN \
  --shm-size=2gb \
  -v ./policies/chromium/policies.json:/etc/opt/chrome/policies/managed/policies.json \
  -p 8080:8080 \
  -p 52000-52100:52000-52100/udp \
  -e NEKO_SCREEN=1920x1080@60 \
  -e NEKO_PASSWORD_ADMIN=${NEKO_PASSWORD_ADMIN}"


# Add NEKO_PASSWORD only if it's set
if [ -n "$NEKO_PASSWORD" ] && [ "$NEKO_PASSWORD" != "null" ]; then
  docker_cmd="$docker_cmd -e NEKO_PASSWORD=${NEKO_PASSWORD}"
fi

# Run the docker command
$docker_cmd m1k1o/neko:google-chrome