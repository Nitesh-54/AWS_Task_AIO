# Creating a test VPC
resource "aws_vpc" "TestVPC" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = var.Instance_tenancy
  tags             = {
   Name            = format("TestVPC-%s", var.tag)
  }
}

# Creating a Public Subnet
resource "aws_subnet" "public_subnet" {
  depends_on               = [aws_vpc.TestVPC]
  vpc_id                   = aws_vpc.TestVPC.id
  cidr_block               = var.public_subnet_cidr
  availability_zone        = var.availability_zone
  map_public_ip_on_launch  = var.map_public_ip_public
  tags                     = {
    Name                   = format("public_subnet-%s", var.tag)
  }
}

# Creating a test Internet Gateway
resource "aws_internet_gateway" "TestINTG" {
  depends_on = [aws_vpc.TestVPC]
  vpc_id     = aws_vpc.TestVPC.id
  tags       = {
    Name     = format("InternetGateway-%s", var.tag)
  }
}

# Creating a test Route table and attaching Internet Gateway 
resource "aws_route_table" "INT_GW_RT" {
  depends_on   = [aws_internet_gateway.TestINTG]
  vpc_id       = aws_vpc.TestVPC.id
  route {
    cidr_block = var.INT_GW_RT_cidr_range
    gateway_id = aws_internet_gateway.TestINTG.id
  }
}

# routetable assosiation with public subnet
resource "aws_route_table_association" "PublicAssociation" {
  depends_on     = [aws_route_table.INT_GW_RT]
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.INT_GW_RT.id
}

#Creating a private subnet
resource "aws_subnet" "private_subnet" {
  depends_on                = [aws_vpc.TestVPC]
  vpc_id                    = aws_vpc.TestVPC.id
  cidr_block                = var.private_subnet_cidr
  availability_zone         = var.availability_zone
  map_public_ip_on_launch   = var.map_public_ip_private
  tags                      = {
    Name                    = format("private_subnet-%s", var.tag)
  }
}

# Creating an Elastic IP
resource "aws_eip" "TestElasticIP" {
    depends_on = [aws_subnet.private_subnet]
    vpc        = true
    tags       = {
        Name   = format("TestElasticIP-%s",var.tag)
    }
}

# Creating a NAT Gateway
resource "aws_nat_gateway" "TestNAT" {
    depends_on        = [aws_eip.TestElasticIP]
    subnet_id         = aws_subnet.private_subnet.id
    allocation_id     = aws_eip.TestElasticIP.id
    tags              = {
      Name            = format("TestNAT-%s",var.tag)
     }
}

# Creating a test Route table and attaching NAT Gateway 
resource "aws_route_table" "NAT_RT" {
  depends_on = [aws_nat_gateway.TestNAT]
  vpc_id     = aws_vpc.TestVPC.id

  route {
    cidr_block = var.NAT_RT_cidr
    gateway_id = aws_nat_gateway.TestNAT.id
  }
}

#routetable assosiation with private subnet
resource "aws_route_table_association" "private" {
  depends_on = [aws_route_table.NAT_RT]
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.NAT_RT.id
}