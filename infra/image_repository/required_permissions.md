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

ECR Repository

* ecr:DescribeRepositories
* ecr:CreateRepository
* ecr:DeleteRepository

Image Push

* ecr:GetAuthorizationToken
* ecr:BatchCheckLayerAvailability
* ecr:InitiateLayerUpload
* ecr:UploadLayerPart
* ecr:PutImage
* ecr:CompleteLayerUpload
