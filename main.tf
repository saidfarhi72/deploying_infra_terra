provider "aws" {
      profile = "default"

  
}

locals {
  vpc_id = aws_vpc.app.id
}
resource "aws_vpc" "app" {


    cidr_block       = var.cidr
      enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "kojitechs-vpc"
  }
}

resource "aws_internet_gateway" "app" {
  #count = var.create_vpc && var.create_igw && length(var.public_subnets) > 0 ? 1 : 0

  vpc_id = local.vpc_id
 tags = {
    Name = "kojitechs-igw"
  }

}

/*
resource "aws_subnet" "private_subnet" {

 count = length(var.private_subnetcidr)

  vpc_id            = aws_vpc.app.id
  cidr_block        = var.private_subnetcidr[count.index]
  availability_zone = var.az[count.index] # element(local.azs,count.index)

  tags = {
    Name = "private-subnet-${count.index + 1}"
  }
}
*/
resource "aws_subnet" "public_subnet" {
  count = length(var.public_subnetcidr)

  vpc_id                  = local.vpc_id
  cidr_block              = var.public_subnetcidr[count.index]
  availability_zone       =var.az[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-${count.index + 1}"
  }
}


resource "aws_route_table" "public_routable" {
  vpc_id = aws_vpc.app.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.app.id
  }

  tags = {
    Name = "public-routetable"
  }
}
resource "aws_route_table_association" "public_routetable_association" {
  count = length(aws_subnet.public_subnet)

  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_routable.id
}

/*
resource "aws_nat_gateway" "this" {
  depends_on = [aws_internet_gateway.app]

  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public_subnet[0].id

  tags = {
    Name = "gw NAT"
  }
}


resource "aws_default_route_table" "defaultroutetable" {
  default_route_table_id = aws_vpc.app.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.this.id
  }
}


resource "aws_eip" "eip" {
  depends_on = [aws_internet_gateway.app]
  vpc        = true
}

*/