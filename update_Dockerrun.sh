#!/bin/bash
# get variables form gitlab-ci or locals
source ./automation/docker_getenv.sh
tmp=$(mktemp)
echo "Patching Dockerrun.aws.json to .Image.Name = \"$REGISTRY/$REPOSITORY:$VERSION\""
jq ".Image.Name = \"$REGISTRY/$REPOSITORY:$VERSION\"" ./Dockerrun.aws.json > "$tmp" && mv "$tmp" ./Dockerrun.aws.json