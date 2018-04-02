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

Zones and Image:

* ec2:DescribeAvailabilityZones
* ec2:DescribeImages

VPC Endpoint:

* ec2:CreateVpcEndpoint
* ec2:DeleteVpcEndpoints
* ec2:DescribeVpcEndpoints
* ec2:DescribePrefixLists

Base Networking:

* ec2:DescribeAddresses
* ec2:AllocateAddress
* ec2:ReleaseAddress
* ec2:DescribeRouteTables
* ec2:CreateRouteTable
* ec2:AssociateRouteTable
* ec2:DisassociateRouteTable
* ec2:DeleteRouteTable
* ec2:DescribeSecurityGroups
* ec2:DescribeNetworkAcls
* ec2:DescribeSubnets
* ec2:CreateSubnet
* ec2:ModifySubnetAttribute
* ec2:DeleteSubnet
* ec2:DescribeInternetGateways
* ec2:CreateInternetGateway
* ec2:AttachInternetGateway
* ec2:DetachInternetGateway
* ec2:DeleteInternetGateway
* ec2:DescribeNatGateways
* ec2:DescribeVpcs
* ec2:CreateVpc
* ec2:DeleteVpc
* ec2:DescribeVpcClassicLink
* ec2:DescribeVpcClassicLinkDnsSupport
* ec2:DescribeVpcAttribute
* ec2:ModifyVpcAttribute
* ec2:CreateNatGateway
* ec2:DeleteNatGateway
* ec2:CreateRoute
* ec2:DeleteRoute
* ec2:CreateTags
* s3:ListBucket
* s3:GetObject
* s3:DeleteObject
* s3:GetObjectTagging
* route53:GetHostedZone
* route53:GetChange
* route53:AssociateVPCWithHostedZone
* route53:DisassociateVPCFromHostedZone
