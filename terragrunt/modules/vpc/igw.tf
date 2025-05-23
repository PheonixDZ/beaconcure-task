##########################################################################
# INTERNET GATEWAY
##########################################################################

resource "aws_internet_gateway" "internet_gateway" {
  depends_on = [aws_vpc.vpc]
  vpc_id     = aws_vpc.vpc.id

  tags = {
    Name = "${var.project}-igw-${var.environment}"
  }
}
