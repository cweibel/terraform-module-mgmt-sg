# terraform-module-mgmt-sg
All the security groups needed to create a Management BOSH

This module will spin up the security groups needed for the protoBOSH.

Inputs - Required:

 - `resource_tags` - AWS tags to apply to resources
 - `vpc_id` - AWS VPC Id
 - `aws_s3_cidrs` - CIDR ranges of s3 ipv4 addresses 
 - `env_cidrs` - CIDR ranges for the subnets in THIS vpc
 - `private_cidrs` - CIDR ranges of all non-public ipv4 addresses

Inputs - Optional: 

 - None

Outputs:

 - `ocfp_mgmt_bosh_sg_id` - security group id for blacksmith and vault
 - `ocfp_mgmt_bastion_sg_id` - security group id for bastion