#!/bin/bash

JENKINS_URL="http://13.217.229.167:8080"
JOB_NAME="auto_infra"
JENKINS_USER="admin"
JENKINS_API_TOKEN="116bbdb62be1ba7c765d4d661b64f2fdfb"

# Fetch CSRF Token
CRUMB_RESPONSE=$(curl -s "${JENKINS_URL}/crumbIssuer/api/json" --user "${JENKINS_USER}:${JENKINS_API_TOKEN}")
echo "CRUMB_RESPONSE: $CRUMB_RESPONSE"

CRUMB=$(echo "$CRUMB_RESPONSE" | jq -r '.crumb')
if [ -z "$CRUMB" ]; then
    echo "Failed to fetch CSRF token. Check CRUMB_RESPONSE."
    exit 1
fi

# Trigger Jenkins Job
RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" -X POST "${JENKINS_URL}/job/${JOB_NAME}/build" \
    --user "${JENKINS_USER}:${JENKINS_API_TOKEN}" \
    -H "Jenkins-Crumb:${CRUMB}")

if [ "$RESPONSE" -eq 201 ]; then
    echo "Jenkins job triggered successfully: ${JOB_NAME}"
else
    echo "Failed to trigger Jenkins job. HTTP response code: $RESPONSE"
    exit 1
fi

# this file is used to assist the Jenkinsfile to create end to end pipeline for the Jenkins server