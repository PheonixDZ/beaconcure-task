###########################################################
## Elastic IP
###########################################################

resource "aws_eip" "elastic_ip" {
  tags = {
    Name = "${var.project}-eip-${var.environment}"
  }
}
