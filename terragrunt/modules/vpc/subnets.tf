##########################################################################
# Public Subnet
##########################################################################

resource "aws_subnet" "public_subnet" {
  depends_on              = [aws_vpc.vpc]
  count                   = length(var.public_subnet_cidr)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnet_cidr[count.index]
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zones[count.index]

  tags = {
    Name                     = "${var.project}-subnet-public-${var.environment}-${var.availability_zones[count.index]}-${count.index + 1}"
    "kubernetes.io/role/elb" = 1
  }
}

##########################################################################
# Private Subnet
##########################################################################

resource "aws_subnet" "private_subnet" {
  depends_on        = [aws_vpc.vpc]
  count             = length(var.private_subnet_cidr)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_subnet_cidr[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name = "${var.project}-subnet-private-${var.environment}-${var.availability_zones[count.index]}-${count.index + 1}"
  }
}
