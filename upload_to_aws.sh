#!/bin/sh

CREDS=`aws sts assume-role --role-arn $PLUGIN_AWS_ASSUME_ROLE_ARN --role-session-name=asd`
export AWS_ACCESS_KEY_ID=`echo $CREDS | jq -r '.Credentials.AccessKeyId'`
export AWS_SECRET_ACCESS_KEY=`echo $CREDS | jq -r '.Credentials.SecretAccessKey'`
export AWS_SESSION_TOKEN=`echo $CREDS | jq -r '.Credentials.SessionToken'`

aws s3 cp --recursive '/drone/src/images' s3://$PLUGIN_S3_BUCKET --metadata '{"Cache-Control":"no-cache", "Content-Type":"image/svg+xml"}'
