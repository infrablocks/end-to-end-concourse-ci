variable "region" {}
variable "component" {}
variable "deployment_identifier" {}

variable "private_network_cidr" {}
variable "version_number" {}

variable "http_basic_username" {}
variable "http_basic_password" {}
variable "github_oauth_client_id" {}
variable "github_oauth_client_secret" {}
variable "github_organization" {}

variable "http_port" {}
variable "ssh_port" {}

variable "web_desired_count" {}
variable "worker_desired_count" {}

variable "ci_gpg_public_key_path" {}

variable "secrets_bucket_name" {}

variable "database_name" {}
variable "database_username" {}
variable "database_password" {}

variable "domain_state_bucket_region" {}
variable "domain_state_bucket_name" {}
variable "domain_state_bucket_is_encrypted" {}
variable "domain_state_key" {}

variable "network_state_bucket_region" {}
variable "network_state_bucket_name" {}
variable "network_state_bucket_is_encrypted" {}
variable "network_state_key" {}

variable "cluster_state_bucket_region" {}
variable "cluster_state_bucket_name" {}
variable "cluster_state_bucket_is_encrypted" {}
variable "cluster_state_key" {}

variable "web_image_repository_state_bucket_region" {}
variable "web_image_repository_state_bucket_name" {}
variable "web_image_repository_state_bucket_is_encrypted" {}
variable "web_image_repository_state_key" {}

variable "worker_image_repository_state_bucket_region" {}
variable "worker_image_repository_state_bucket_name" {}
variable "worker_image_repository_state_bucket_is_encrypted" {}
variable "worker_image_repository_state_key" {}

variable "database_state_bucket_region" {}
variable "database_state_bucket_name" {}
variable "database_state_bucket_is_encrypted" {}
variable "database_state_key" {}
