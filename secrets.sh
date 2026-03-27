#!/bin/bash

cd /home/node
source .env;

mkdir -p .gradle
echo "gitLabPrivateToken=$GITLAB_PRIVATE_TOKEN" >> .gradle/gradle.properties;

# EOF

