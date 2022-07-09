# # 1. Create vpc

resource "aws_vpc" "vpcs" {
  count = length(var.VPCnames)
  # name = var.VPCnames[count.index]
  cidr_block = "10.${count.index + 1}.0.0/24"
  enable_dns_hostnames = true
  tags = {
    Name = "${var.VPCnames[count.index]}VPC"
  }
}