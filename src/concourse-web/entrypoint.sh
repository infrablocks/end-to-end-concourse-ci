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
    ${CONCOURSE_SESSION_SIGNING_PRIVATE_KEY_PATH} \
    /concourse-secrets/session_signing_key.private
aws s3 cp --sse AES256 --region ${AWS_REGION} \
    ${CONCOURSE_TSA_HOST_PRIVATE_KEY_PATH} \
    /concourse-secrets/tsa_host_key.private
aws s3 cp --sse AES256 --region ${AWS_REGION} \
    ${CONCOURSE_AUTHORIZED_WORKER_KEYS_PATH} \
    /concourse-secrets/authorized_worker_keys

# Determine self IP
SELF_IP=$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)

# Expose keys
export CONCOURSE_SESSION_SIGNING_KEY="/concourse-secrets/session_signing_key.private"
export CONCOURSE_TSA_HOST_KEY="/concourse-secrets/tsa_host_key.private"
export CONCOURSE_TSA_AUTHORIZED_KEYS="/concourse-secrets/authorized_worker_keys"

# Expose additional config
export CONCOURSE_PEER_ADDRESS="${SELF_IP}"

# Starting
echo "Starting concourse web at IP: ${SELF_IP}"

# Delegate to concourse
/usr/bin/dumb-init /usr/local/concourse/bin/concourse web
