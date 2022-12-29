## Variables

variable resource_tags {} # AWS tags to apply to resources               (required)
variable vpc_id        {} # Pass in the AWS VPC Id                       (required)
variable aws_s3_cidrs  {} # CIDR ranges of s3 ipv4 addresses             (required)
variable env_cidrs     {} # CIDR ranges for the subnets in THIS vpc      (required)
variable private_cidrs {} # CIDR ranges of all non-public ipv4 addresses (required)


################################################################################
# OCFP Management BOSH Security Group
################################################################################
resource "aws_security_group" "ocfp_mgmt_bosh_sg" {
  name          = "mgmt-bosh-sg"
  description   = "Inbound & outbound INTERNAL traffic for Management BOSH & Deployments"
  vpc_id        = var.vpc_id
  
  revoke_rules_on_delete = true
  
  # Env Subnets
  ingress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = var.env_cidrs
  }
  ingress {
    from_port   = 443
    protocol    = "TCP"
    to_port     = 443
    cidr_blocks = var.private_cidrs
  }
  # AWS S3
  ingress {
    from_port   = 443
    protocol    = "TCP"
    to_port     = 443
    cidr_blocks = var.aws_s3_cidrs
  }

  tags          = merge({Name = "mgmt-bosh-sg"}, var.resource_tags )
}


output "ocfp_mgmt_bosh_sg_id" {
    value = "${aws_security_group.ocfp_mgmt_bosh_sg.id}"
}




################################################################################
# OCFP Management Bastion Security Group
################################################################################
resource "aws_security_group" "ocfp_mgmt_bastion_sg" {
  name          = "mgmt-bastion-sg"
  description   = "Inbound & outbound INTERNAL traffic for Bastion"
  vpc_id        = var.vpc_id

  # Env Subnets
  ingress {
    from_port   = 22
    protocol    = "TCP"
    to_port     = 22
    cidr_blocks = var.private_cidrs
  }

  tags          = merge({Name = "mgmt-bastion-sg"}, var.resource_tags )

}

output "ocfp_mgmt_bastion_sg_id" {
    value = "${aws_security_group.ocfp_mgmt_bastion_sg.id}"
}
