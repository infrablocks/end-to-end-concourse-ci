Required Permissions
====================

Terraform:

* iam:GetUser
* sts:GetCallerIdentity
* ec2:DescribeAccountAttributes

Backend:

* s3:ListBucket
* s3:GetObject
* s3:PutObject

Encrypted Bucket:

* s3:CreateBucket
* s3:ListBucket
* s3:GetBucketCORS
* s3:GetBucketVersioning
* s3:GetAccelerateConfiguration
* s3:GetBucketRequestPayment
* s3:GetBucketLogging
* s3:GetLifecycleConfiguration
* s3:GetReplicationConfiguration
* s3:GetBucketLocation
* s3:GetBucketTagging
* s3:PutBucketTagging
* s3:PutBucketVersioning
* s3:PutBucketPolicy
* s3:PutBucketAcl
* s3:DeleteBucketPolicy
* s3:DeleteBucket
