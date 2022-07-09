# # 4. Create a Subnet 

resource "aws_subnet" "etk_subnets" {
  count = 3
#   name = "${var.VPCnames[1]}"
  vpc_id                              = aws_vpc.vpcs[0].id
  cidr_block                          = "10.1.0.${64 * count.index}/26"
  availability_zone                   = "us-east-1a"
  private_dns_hostname_type_on_launch = "resource-name"
  map_public_ip_on_launch             = true
  tags = {
    Name = "subnet-${var.VPCnames[0]}-${count.index + 1}"
  }
}
resource "aws_subnet" "tc0_subnets" {
  count = 3
#   name = "${var.VPCnames[1]}"
  vpc_id                              = aws_vpc.vpcs[1].id
  cidr_block                          = "10.2.0.${64 * count.index}/26"
  availability_zone                   = "us-east-1a"
  private_dns_hostname_type_on_launch = "resource-name"
  map_public_ip_on_launch             = true
  tags = {
    Name = "subnet-${var.VPCnames[1]}-${count.index + 1}"
  }
}
resource "aws_subnet" "epa_subnets" {
  count = 3
#   name = "${var.VPCnames[1]}"
  vpc_id                              = aws_vpc.vpcs[2].id
  cidr_block                          = "10.3.0.${64 * count.index}/26"
  availability_zone                   = "us-east-1a"
  private_dns_hostname_type_on_launch = "resource-name"
  map_public_ip_on_launch             = true
  tags = {
    Name = "subnet-${var.VPCnames[2]}-${count.index + 1}"
  }
}
resource "aws_subnet" "epaBiEfile_subnets" {
  count = 3
#   name = "${var.VPCnames[1]}"
  vpc_id                              = aws_vpc.vpcs[3].id
  cidr_block                          = "10.4.0.${64 * count.index}/26"
  availability_zone                   = "us-east-1a"
  private_dns_hostname_type_on_launch = "resource-name"
  map_public_ip_on_launch             = true
  tags = {
    Name = "subnet-${var.VPCnames[3]}-${count.index + 1}"
  }
}

# # 5. Associate subnet with Route Table
resource "aws_route_table_association" "etk_Rta" {
  count = length(resource.aws_subnet.etk_subnets) - 1
  subnet_id      = resource.aws_subnet.etk_subnets[count.index + 1].id
  route_table_id = resource.aws_route_table.etk_route-table.id
}
resource "aws_route_table_association" "tc0_Rta" {
  count = length(resource.aws_subnet.tc0_subnets) - 1
  subnet_id      = resource.aws_subnet.tc0_subnets[count.index + 1].id
  route_table_id = resource.aws_route_table.tc0_route-table.id
}
resource "aws_route_table_association" "epa_Rta" {
  count = length(resource.aws_subnet.epa_subnets) - 1
  subnet_id      = resource.aws_subnet.epa_subnets[count.index + 1].id
  route_table_id = resource.aws_route_table.epa_route-table.id
}
resource "aws_route_table_association" "epaBiEfileRta" {
  count = length(resource.aws_subnet.epaBiEfile_subnets) - 1
  subnet_id      = resource.aws_subnet.epaBiEfile_subnets[count.index + 1].id
  route_table_id = resource.aws_route_table.epaBiEfile_route-table.id
}

#for public subnets
resource "aws_route_table_association" "etk_Rta_pub" {
  subnet_id      = resource.aws_subnet.etk_subnets[0].id
  route_table_id = resource.aws_route_table.etk_route-table_pub.id
}
resource "aws_route_table_association" "tc0_Rta_pub" {
  subnet_id      = resource.aws_subnet.tc0_subnets[0].id
  route_table_id = resource.aws_route_table.tc0_route-table_pub.id
}
resource "aws_route_table_association" "epa_Rta_pub" {
  subnet_id      = resource.aws_subnet.epa_subnets[0].id
  route_table_id = resource.aws_route_table.epa_route-table_pub.id
}
resource "aws_route_table_association" "epaBiEfileRta_pub" {
  subnet_id      = resource.aws_subnet.epaBiEfile_subnets[0].id
  route_table_id = resource.aws_route_table.epaBiEfile_route-table_pub.id
}
# # 3. Create Route Tables
#route table for public subnets needs to be different
#cannot loop because nat gatway ids resource needs to be refferenced individually
#private route tables
resource "aws_route_table" "etk_route-table" {
  vpc_id = resource.aws_vpc.vpcs[0].id

  route {
    cidr_block         = "172.0.0.0/16"
    vpc_peering_connection_id =  resource.aws_vpc_peering_connection.vpcPeering[0].id
  }


  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = resource.aws_nat_gateway.etk_NAT.id
  }

  tags = {
    Name = "${var.VPCnames[0]}Rt"
  }
}

resource "aws_route_table" "tc0_route-table" {
  vpc_id = resource.aws_vpc.vpcs[1].id

  route {
    cidr_block         = "172.0.0.0/16"
    vpc_peering_connection_id =  resource.aws_vpc_peering_connection.vpcPeering[1].id
  }


  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = resource.aws_nat_gateway.tc0_NAT.id
  }

  tags = {
    Name = "${var.VPCnames[1]}Rt"
  }
}

resource "aws_route_table" "epa_route-table" {
  vpc_id = resource.aws_vpc.vpcs[2].id

  route {
    cidr_block         = "172.0.0.0/16"
    vpc_peering_connection_id =  resource.aws_vpc_peering_connection.vpcPeering[2].id
  }


  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = resource.aws_nat_gateway.epa_NAT.id
  }

  tags = {
    Name = "${var.VPCnames[2]}Rt"
  }
}

resource "aws_route_table" "epaBiEfile_route-table" {
  vpc_id = resource.aws_vpc.vpcs[3].id

  route {
    cidr_block         = "172.0.0.0/16"
    vpc_peering_connection_id =  resource.aws_vpc_peering_connection.vpcPeering[3].id
  }


  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = resource.aws_nat_gateway.epaBiEfile_NAT.id
  }

  tags = {
    Name = "${var.VPCnames[3]}Rt"
  }
}
#Public Routes
resource "aws_route_table" "etk_route-table_pub" {
  vpc_id = resource.aws_vpc.vpcs[0].id

  route {
    cidr_block         = "172.0.0.0/16"
    vpc_peering_connection_id =  resource.aws_vpc_peering_connection.vpcPeering[0].id
  }


  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = resource.aws_internet_gateway.igw[0].id
  }

  tags = {
    Name = "${var.VPCnames[0]}PubRt"
  }
}

resource "aws_route_table" "tc0_route-table_pub" {
  vpc_id = resource.aws_vpc.vpcs[1].id

  route {
    cidr_block         = "172.0.0.0/16"
    vpc_peering_connection_id =  resource.aws_vpc_peering_connection.vpcPeering[1].id
  }


  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = resource.aws_internet_gateway.igw[1].id
  }

  tags = {
    Name = "${var.VPCnames[1]}PubRt"
  }
}

resource "aws_route_table" "epa_route-table_pub" {
  vpc_id = resource.aws_vpc.vpcs[2].id

  route {
    cidr_block         = "172.0.0.0/16"
    vpc_peering_connection_id =  resource.aws_vpc_peering_connection.vpcPeering[2].id
  }


  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = resource.aws_internet_gateway.igw[2].id
  }

  tags = {
    Name = "${var.VPCnames[2]}RtPub"
  }
}

resource "aws_route_table" "epaBiEfile_route-table_pub" {
  vpc_id = resource.aws_vpc.vpcs[3].id

  route {
    cidr_block         = "172.0.0.0/16"
    vpc_peering_connection_id =  resource.aws_vpc_peering_connection.vpcPeering[3].id
  }


  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = resource.aws_internet_gateway.igw[3].id
  }

  tags = {
    Name = "${var.VPCnames[3]}PubRt"
  }
}