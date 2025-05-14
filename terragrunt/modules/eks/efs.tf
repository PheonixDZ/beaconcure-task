#EFS File System
resource "aws_efs_file_system" "efs" {
  creation_token   = "${var.project}-efs-${var.environment}"
  performance_mode = "generalPurpose"
  throughput_mode  = "bursting"
  encrypted        = true

  tags = {
    Name = "${var.project}-efs-${var.environment}"
  }
}

#EFS Security Group
resource "aws_security_group" "efs_sg" {
  name        = "${var.project}-efs-sg-${var.environment}"
  description = "Allow NFS access"
  vpc_id      = var.vpc_id

  # Allow NFS access from EKS nodes
  ingress {
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = var.vpc_cidr_block
  }
  # Allow outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project}-efs-sg-${var.environment}"
  }
}

#EFS Mount Targets
resource "aws_efs_mount_target" "efs_mount" {
  count           = length(var.subnet_ids)
  file_system_id  = aws_efs_file_system.efs.id
  subnet_id       = var.subnet_ids[count.index]
  security_groups = [aws_security_group.efs_sg.id]
}

# Storage Class
resource "kubernetes_storage_class_v1" "efs" {
  metadata {
    name = "efs"
  }

  storage_provisioner = "efs.csi.aws.com"

  parameters = {
    provisioningMode = "efs-ap"
    fileSystemId     = aws_efs_file_system.efs.id
    directoryPerms   = "700"
  }

  mount_options = ["iam"]

  depends_on = [
    aws_eks_cluster.eks_cluster,
    aws_eks_addon.addon
  ]
}
