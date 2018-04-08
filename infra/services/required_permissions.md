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

B-Social Service

* s3:ListBucket
* s3:GetObject
* s3:PutObject
* s3:DeleteObject
* s3:GetObjectTagging
* s3:ListBucketVersions
* s3:DeleteObjectVersion
* ec2:DescribeVpcs
* ec2:DescribeVpcAttribute
* ec2:DescribeSecurityGroups
* ec2:CreateSecurityGroup
* ec2:DeleteSecurityGroup
* ec2:AuthorizeSecurityGroupIngress
* ec2:AuthorizeSecurityGroupEgress
* ec2:RevokeSecurityGroupEgress
* ec2:DescribeNetworkInterfaces
* ec2:DetachNetworkInterface
* acm:ListCertificates
* iam:GetUser
* iam:CreateUser
* iam:DeleteUser
* iam:ListAccessKeys
* iam:CreateAccessKey
* iam:DeleteAccessKey
* iam:GetUserPolicy
* iam:PutUserPolicy
* iam:GetRole
* iam:CreateRole
* iam:DeleteRole
* iam:GetRolePolicy
* iam:PutRolePolicy
* iam:DeleteRolePolicy
* iam:ListInstanceProfilesForRole
* elasticloadbalancing:DescribeLoadBalancers
* elasticloadbalancing:CreateLoadBalancer
* elasticloadbalancing:DeleteLoadBalancer
* elasticloadbalancing:DescribeLoadBalancerAttributes
* elasticloadbalancing:CreateLoadBalancerListeners
* elasticloadbalancing:DescribeTags
* elasticloadbalancing:AddTags
* elasticloadbalancing:ModifyLoadBalancerAttributes
* elasticloadbalancing:ConfigureHealthCheck
* elasticloadbalancing:ApplySecurityGroupsToLoadBalancer
* elasticloadbalancing:AttachLoadBalancerToSubnets
* route53:GetHostedZone
* route53:ChangeResourceRecordSets
* route53:GetChange
* route53:ListResourceRecordSets

ECS Service

* iam:PassRole
* ecs:DescribeTaskDefinition
* ecs:RegisterTaskDefinition
* ecs:DeregisterTaskDefinition
* ecs:DescribeServices
* ecs:CreateService
* ecs:UpdateService
* ecs:DeleteService
* logs:DescribeLogGroups
* logs:CreateLogGroup
* logs:DeleteLogGroup
* logs:ListTagsLogGroup
* logs:TagLogGroup
