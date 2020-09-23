#!/bin/bash
# table utils
source ./automation/printTable.sh

DOCKER_TAG_PROTECTION=true


if [ -z "$NAMESPACE" ]; then
    git_url=$(git config --get remote.origin.url)
    paths=(${git_url//// })
    
    NAMESPACE=${paths[-2],,}
      if [[ $NAMESPACE == *":"* ]]; then
            paths=(${NAMESPACE/:/ })
            NAMESPACE=${paths[-1],,}
      fi
fi

#get reponame
git_url=$(basename $(git config --get remote.origin.url))
REPONAME=${git_url/\.git/''}

AUTOMATION_SHORT=$(cd automation;git rev-parse --short HEAD)
AUTOMATION_BRANCH_NAME=$(cd automation;git rev-parse --abbrev-ref HEAD)
GIT_SHORT=$(git rev-parse --short HEAD) 

GIT_LAST_TAG=$(git tag --sort=committerdate|tail -n 1)  > /dev/null 2>&1
#get BRANCH_NAME from  GIT
if [ -z $GIT_BRANCH ]; then
  BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD)
else 
  BRANCH_NAME=$GIT_BRANCH
fi

# 1 try to get version from package json
if [[ ( ! -z "$VERSION" ) || ( -f "./package.json" ) ]]
      then
      VERSION=`jq -r '.version' ./package.json`
fi

# 2 last tag 
if [[ ( ! -z "$VERSION" )  || ( ! -z "$GIT_LAST_TAG" ) ]]
      then
      VERSION=$GIT_LAST_TAG
fi


# 3 use "latest"
if [ -z "$VERSION" ]; then
      VERSION="latest"
fi

# check repository
if [ -z "$REPOSITORY" ]
then
      REPOSITORY="$NAMESPACE/$REPONAME"
fi

# check registry if not present then set to gitlab ECR
if [ -z "$REGISTRY" ]
then
      REGISTRY=""

fi
# build DOCKER_IMAGENAME
if [ -z "$DOCKER_IMAGENAME" ]
   then   
      if [ ! -z "REGISTRY" ]
            then
                  DOCKER_IMAGENAME=$REPOSITORY
            else
                  DOCKER_IMAGENAME=$REGISTRY/$REPOSITORY
      fi
      
fi

# check git user
if [ -z "$GITLAB_USER_LOGIN" ]
      then
            GIT_USER=$(git log -1 --pretty=format:'%an')
      else
            GIT_USER=$GITLAB_USER_LOGIN
fi
# check git user_email
if [ -z "$GITLAB_USER_EMAIL" ]
      then
            GIT_USER_EMAIL=$(git log -1 --pretty=format:'%ae')
      else
            GIT_USER_EMAIL=$GITLAB_USER_EMAIL
fi
# echo result
# echo result
echo -e "\n\e[1;32m»» AUTOMATION: $AUTOMATION_SHORT $AUTOMATION_BRANCH_NAME \e[1;34m"
printTable ',' "$(cat <<EOF
VAR,VALUE
GIT_SHORT,$GIT_SHORT
GIT_LAST_TAG,$GIT_LAST_TAG
BRANCH_NAME,$BRANCH_NAME 
REGISTRY,$REGISTRY 
NAMESPACE,$NAMESPACE 
VERSION,$VERSION 
REPOSITORY,$REPOSITORY 
DOCKER_IMAGENAME,$DOCKER_IMAGENAME
DOCKER_TAG_PROTECTION,$DOCKER_TAG_PROTECTION
GIT_USER,$GIT_USER 
GIT_USER_EMAIL,$GIT_USER_EMAIL 

EOF
)
"
echo -e "\e[0m \n\n\n"
set +x