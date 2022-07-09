# 6. Create Security Group to allow port 22,80,443

resource "aws_security_group" "TerraformSecurityGroup" {
  count       = length(resource.aws_vpc.vpcs)
  name        = "allow_all_traffic"
  description = "Allow inbound traffic"
  vpc_id      = resource.aws_vpc.vpcs[count.index].id

  ingress {
    description = "all internal traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.0.0.0/8"]
  }
  ingress {
    description = "all internal traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["172.0.0.0/8"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_all"
  }
}

# # 7. Create a network interface with an ip in the subnet that was created in step 4
# resource "aws_network_interface" "etk_nics" {
#   count           = length(resource.aws_subnet.vpnsubnets)
#   subnet_id       = resource.aws_subnet.vpnsubnets[count.index].id
#   private_ips     = ["10.1.0.${count.index + 50 + count.index * 64}"]
#   security_groups = [resource.aws_security_group.TerraformSecurityGroup[0].id]
# }
# resource "aws_network_interface" "tc0_nics" {
#   count           = length(resource.aws_subnet.apps1subnets)
#   subnet_id       = resource.aws_subnet.apps1subnets[count.index].id
#   private_ips     = ["10.2.0.${count.index + 50 + count.index * 64}"]
#   security_groups = [resource.aws_security_group.TerraformSecurityGroup[1].id]
# }
# resource "aws_network_interface" "epa_nics" {
#   count           = length(resource.aws_subnet.apps2subnets)
#   subnet_id       = resource.aws_subnet.apps2subnets[count.index].id
#   private_ips     = ["10.3.0.${count.index + 50 + count.index * 64}"]
#   security_groups = [resource.aws_security_group.TerraformSecurityGroup[2].id]
# }
# resource "aws_network_interface" "epaBiEfile_nics" {
#   count           = length(resource.aws_subnet.dbsubnets)
#   subnet_id       = resource.aws_subnet.dbsubnets[count.index].id
#   private_ips     = ["10.4.0.${count.index + 50 + count.index * 64}"]
#   security_groups = [resource.aws_security_group.TerraformSecurityGroup[3].id]
# }