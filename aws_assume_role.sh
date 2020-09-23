#!/bin/bash 
#TODO check if in a ci envinronment or local

if [ -n "$JENKINS_HOME" ]; then
echo "Assuming role AwsPipelineUser"
temp_role=$(aws sts assume-role \
    --role-arn "arn:aws:iam::$TARGET_AWS_ACCOUNT:role/$TARGET_AWS_ROLE" \
    --role-session-name "AwsPipelineUser" \
    --region "$TARGET_REGION")

export AWS_ACCESS_KEY_ID=$(echo $temp_role | jq -r .Credentials.AccessKeyId)
export AWS_SECRET_ACCESS_KEY=$(echo $temp_role | jq -r .Credentials.SecretAccessKey)
export AWS_SESSION_TOKEN=$(echo $temp_role | jq -r .Credentials.SessionToken)
fi