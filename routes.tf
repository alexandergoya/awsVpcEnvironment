# # # 2. Create Internet Gateway
resource "aws_internet_gateway" "igw" {
  count = length(resource.aws_vpc.vpcs)
  vpc_id = resource.aws_vpc.vpcs[count.index].id
}

## Create Elastic IP
resource "aws_eip" "eip" {
  count = length(resource.aws_vpc.vpcs)
  #instance = aws_instance.web.id
  #vpc      = true
}
## Create NAT Gateway
resource "aws_nat_gateway" "etk_NAT" {
  allocation_id = aws_eip.eip[0].id
  subnet_id     = resource.aws_subnet.etk_subnets[0].id
  tags = {
    Name = "gw NAT{$var.VPCnames[0]}"
  }
}
resource "aws_nat_gateway" "tc0_NAT" {
  allocation_id = aws_eip.eip[1].id
  subnet_id     = resource.aws_subnet.tc0_subnets[0].id
  tags = {
    Name = "gw NAT{$var.VPCnames[1]}"
  }
}
  resource "aws_nat_gateway" "epa_NAT" {
  allocation_id = aws_eip.eip[2].id
  subnet_id     = resource.aws_subnet.epa_subnets[0].id
  tags = {
    Name = "gw NAT{$var.VPCnames[2]}"
  }
}
  resource "aws_nat_gateway" "epaBiEfile_NAT" {
  allocation_id = aws_eip.eip[3].id
  subnet_id     = resource.aws_subnet.epaBiEfile_subnets[0].id
  tags = {
    Name = "gw NAT{$var.VPCnames[3]}"
  }
}

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  # depends_on = [resource.aws_internet_gateway.igw[count.index]]

## Create vpc peering connections
data "aws_vpc" "selected" {
  id = "vpc-81f025f9"
}
resource "aws_vpc_peering_connection" "vpcPeering" {
  count = length(var.VPCnames)
  peer_owner_id = var.accountOwner
  peer_vpc_id   = data.aws_vpc.selected.id
  vpc_id        = resource.aws_vpc.vpcs[count.index].id
  auto_accept   = true
}
# allow_remote_vpc_dns_resolution = true