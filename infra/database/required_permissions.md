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

RDS Database:

* ec2:DescribeSecurityGroups
* ec2:CreateSecurityGroup
* ec2:DeleteSecurityGroup
* ec2:RevokeSecurityGroupEgress
* ec2:AuthorizeSecurityGroupIngress
* ec2:CreateTags
* ec2:DescribeNetworkInterfaces
* rds:DescribeDBInstances
* rds:CreateDBInstance
* rds:DescribeDBSubnetGroups
* rds:CreateDBSubnetGroup
* rds:DeleteDBSubnetGroup
* rds:ListTagsForResource
* rds:AddTagsToResource
