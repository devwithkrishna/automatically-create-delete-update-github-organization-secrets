#! /bin/bash

# The organization name. The name is not case sensitive.
ORGANIZATION=$1
SECRET_NAME=$2
# Checking if the Organization name or secret name is non-empty
if [ -z "$ORGANIZATION" ] || [ -z "$SECRET_NAME" ]; then
  echo "Either Organization name or Secret name is empty"
  echo "Usage: $0 <Organization name> <Secret name>"
  exit 1
fi
# Making the API call and capturing the response
response=$(curl -sL \
  -X DELETE \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $GH_TOKEN" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/orgs/$ORGANIZATION/actions/secrets/$SECRET_NAME)


