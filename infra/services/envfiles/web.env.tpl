CONCOURSE_CLUSTER_NAME="Infrablocks Demo"

CONCOURSE_ADD_LOCAL_USER="${http_basic_username}:${http_basic_password}"

CONCOURSE_GITHUB_CLIENT_ID="${github_oauth_client_id}"
CONCOURSE_GITHUB_CLIENT_SECRET="${github_oauth_client_secret}"

CONCOURSE_MAIN_TEAM_LOCAL_USER="${http_basic_username}"
CONCOURSE_MAIN_TEAM_GITHUB_ORG="${github_organization}"

CONCOURSE_POSTGRES_HOST="${database_host}"
CONCOURSE_POSTGRES_USER="${database_username}"
CONCOURSE_POSTGRES_PASSWORD="${database_password}"
CONCOURSE_POSTGRES_DATABASE="${database_name}"

CONCOURSE_EXTERNAL_URL="${external_url}"
CONCOURSE_OAUTH_BASE_URL="${oauth_base_url}"

CONCOURSE_SESSION_SIGNING_KEY_FILE_OBJECT_PATH="s3://${secrets_bucket}/${session_signing_private_key_key}"
CONCOURSE_TSA_HOST_KEY_FILE_OBJECT_PATH="s3://${secrets_bucket}/${tsa_host_private_key_key}"
CONCOURSE_TSA_AUTHORIZED_KEYS_FILE_OBJECT_PATH="s3://${secrets_bucket}/${authorized_worker_keys_key}"
