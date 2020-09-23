#!/bin/bash
	
##############################
## Get Environment Variables #
##############################
source ./automation/docker_getenv.sh


###############################################
## Pushing the image to repository on AWS ECR #
###############################################
docker push $DOCKER_IMAGENAME:$VERSION || exit 1