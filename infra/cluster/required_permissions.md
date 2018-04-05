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

ECS Cluster

* iam:GetPolicy
* iam:GetPolicyVersion
* iam:ListPolicyVersions
* iam:ListEntitiesForPolicy
* iam:CreatePolicy
* iam:DeletePolicy
* iam:GetRole
* iam:PassRole
* iam:CreateRole
* iam:DeleteRole
* iam:ListRolePolicies
* iam:AttachRolePolicy
* iam:DetachRolePolicy
* iam:GetInstanceProfile
* iam:CreateInstanceProfile
* iam:ListInstanceProfilesForRole
* iam:AddRoleToInstanceProfile
* iam:RemoveRoleFromInstanceProfile
* iam:DeleteInstanceProfile
* ec2:DescribeSecurityGroups
* ec2:CreateSecurityGroup
* ec2:DeleteSecurityGroup
* ec2:AuthorizeSecurityGroupIngress
* ec2:AuthorizeSecurityGroupEgress
* ec2:RevokeSecurityGroupEgress
* ec2:ImportKeyPair
* ec2:DescribeKeyPairs
* ec2:DeleteKeyPair
* ec2:CreateTags
* ec2:DescribeImages
* ec2:DescribeNetworkInterfaces
* ecs:DescribeClusters
* ecs:CreateCluster
* ecs:DeleteCluster
* autoscaling:DescribeLaunchConfigurations
* autoscaling:CreateLaunchConfiguration
* autoscaling:DeleteLaunchConfiguration
* autoscaling:DescribeScalingActivities
* autoscaling:DescribeAutoScalingGroups
* autoscaling:CreateAutoScalingGroup
* autoscaling:UpdateAutoScalingGroup
* autoscaling:DeleteAutoScalingGroup
* logs:CreateLogGroup
* logs:DescribeLogGroups
* logs:ListTagsLogGroup
* logs:DeleteLogGroup
