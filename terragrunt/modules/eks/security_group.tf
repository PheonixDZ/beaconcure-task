########################################################
# Security Group - EKS Cluster
########################################################

# Create a security group for the EKS cluster
resource "aws_security_group" "eks_security_group" {
  name   = "${var.project}-eks-sg-${var.environment}"
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.project} EKS Security Group ${var.environment}"
  }
}

########################################################
# Security Group Rules - Ingress (Inbound Traffic)
########################################################

# Define ingress rules for the EKS security group
resource "aws_security_group_rule" "eks_ingress_rules" {
  count = length(var.eks_ingress_rules)

  security_group_id = aws_security_group.eks_security_group.id
  type              = "ingress"

  # Allow inbound traffic based on CIDR blocks and ports
  cidr_blocks = var.eks_ingress_cidr_blocks
  from_port   = var.eks_ingress_rules_from_port[count.index]
  to_port     = var.eks_ingress_rules_to_port[count.index]
  protocol    = var.eks_ingress_rules_protocols[count.index]
}

########################################################
# Security Group Rules - Egress (Outbound Traffic)
########################################################

# Define egress rules for the EKS security group
resource "aws_security_group_rule" "eks_egress_rules" {
  count = length(var.eks_egress_rules)

  security_group_id = aws_security_group.eks_security_group.id
  type              = "egress"

  # Allow outbound traffic based on CIDR blocks and ports
  cidr_blocks = var.eks_egress_cidr_blocks
  from_port   = var.eks_egress_rules_from_port[count.index]
  to_port     = var.eks_egress_rules_to_port[count.index]
  protocol    = var.eks_egress_rules_protocols[count.index]
}
