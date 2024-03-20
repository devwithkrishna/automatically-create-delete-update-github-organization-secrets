#! /bin/bash

# The organization name. The name is not case sensitive.
ORGANIZATION=$1

# Checking if the Organization name is non-empty
if [ -z "$ORGANIZATION" ]; then
  echo "Organization name is empty"
  echo "Usage: $0 <Organization name>"
  exit 1
fi

# Making the API call and capturing the response
response=$(curl -sL \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $GH_TOKEN" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/orgs/$ORGANIZATION/actions/secrets/public-key)

sleep 10
# Checking if the request was successful (status code 200)
if [ ! -z "$response" ]; then
  # Extracting the public key from the response
  public_key_id=$(echo "$response" | jq -r '.key_id')
  echo "$public_key_id"

else
  echo "Failed to retrieve public key id for $ORGANIZATION. Response is empty."
fi
