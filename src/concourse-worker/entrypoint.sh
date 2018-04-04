#!/bin/bash

# Ensure ENVIRONMENT_OBJECT_PATH environment variable is present
if [ -z "$ENVIRONMENT_OBJECT_PATH" ]; then
  echo >&2 'Error: missing ENVIRONMENT_OBJECT_PATH environment variable.'
  exit 1
fi

# Ensure AWS_REGION environment variable is present
if [ -z "$AWS_REGION" ]; then
  echo >&2 'Error: missing AWS_REGION environment variable.'
  exit 1
fi

# Create secrets directory
mkdir /concourse-secrets

# Fetch and source env file
eval $(aws s3 cp --sse AES256 --region ${AWS_REGION} \
    ${ENVIRONMENT_OBJECT_PATH} - | sed 's/^/export /')

# Fetch keys
aws s3 cp --sse AES256 --region ${AWS_REGION} \
    ${CONCOURSE_TSA_HOST_PUBLIC_KEY_PATH} \
    /concourse-secrets/tsa_host_key.public
aws s3 cp --sse AES256 --region ${AWS_REGION} \
    ${CONCOURSE_WORKER_PRIVATE_KEY_PATH} \
    /concourse-secrets/worker_key.private

# Determine self IP
SELF_IP=$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)

# Expose keys
export CONCOURSE_TSA_PUBLIC_KEY="/concourse-secrets/tsa_host_key.public"
export CONCOURSE_TSA_WORKER_PRIVATE_KEY="/concourse-secrets/worker_key.private"

# Expose additional config
export CONCOURSE_PEER_IP="${SELF_IP}"

# Starting
echo "Starting concourse worker at IP: ${SELF_IP}"

# Delegate to concourse
/usr/local/bin/dumb-init /usr/local/bin/concourse worker