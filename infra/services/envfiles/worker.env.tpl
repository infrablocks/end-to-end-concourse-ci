CONCOURSE_TSA_HOST="${tsa_host}:${ssh_port}"
CONCOURSE_EPHEMERAL="true"

CONCOURSE_TSA_PUBLIC_KEY_FILE_OBJECT_PATH="s3://${secrets_bucket}/${tsa_host_public_key_key}"
CONCOURSE_TSA_WORKER_PRIVATE_KEY_FILE_OBJECT_PATH="s3://${secrets_bucket}/${worker_private_key_key}"
