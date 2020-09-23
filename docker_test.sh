#!/bin/bash
# get variables form gitlab-ci or locals
source ./automation/docker_getenv.sh


docker run -it -p 3000:3000 --rm $DOCKER_IMAGENAME:$VERSION $1