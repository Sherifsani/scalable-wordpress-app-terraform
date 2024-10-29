# vpc
resource "aws_vpc" "wordpress" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "wordpress"
  }
}

# public subnets
resource "aws_subnet" "public-subnets" {
  count                   = length(var.public-cidr-ranges)
  vpc_id                  = aws_vpc.wordpress.id
  cidr_block              = var.public-cidr-ranges[count.index]
  availability_zone       = var.azs[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-${count.index + 1}"
  }
}

# private subnets
resource "aws_subnet" "private-subnets" {
  count             = length(var.private-cidr-ranges)
  vpc_id            = aws_vpc.wordpress.id
  cidr_block        = element((var.private-cidr-ranges), count.index)
  availability_zone = element((var.azs), count.index)

  tags = {
    Name = "private-subnet-${count.index + 1}"
  }
}

# internet gateway
resource "aws_internet_gateway" "wordpress_igw" {
  vpc_id = aws_vpc.wordpress.id

  tags = {
    Name = "wordpress-igw"
  }
}

# route table for public subnets to the internet gateway
resource "aws_route_table" "igw-rtb" {
  vpc_id = aws_vpc.wordpress.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.wordpress_igw.id
  }

  tags = {
    Name = "igw-rtb"
  }

}

resource "aws_route_table_association" "rtb-assoc" {
  count          = length(var.public-cidr-ranges)
  subnet_id      = element(aws_subnet.public-subnets[*].id, count.index)
  route_table_id = aws_route_table.igw-rtb.id
}

resource "aws_eip" "nat_eip" {
  count  = length(var.public-cidr-ranges)
  domain = "vpc"
}

resource "aws_nat_gateway" "nat_gw" {
  count         = length(var.public-cidr-ranges)
  allocation_id = aws_eip.nat_eip[count.index].id
  subnet_id     = aws_subnet.public-subnets[count.index].id

  tags = {
    Name = "wordpress_nat_gw_${count.index + 1}"
  }
}

resource "aws_route_table" "nat-rtb" {
  vpc_id = aws_vpc.wordpress.id
  count  = length((var.public-cidr-ranges))

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw[count.index].id
  }

  tags = {
    Name = "nat_rtb_${count.index + 1}"
  }
}

resource "aws_route_table_association" "nat-rtb-assoc" {
  count          = length(var.private-cidr-ranges)
  subnet_id      = aws_subnet.private-subnets[count.index].id
  route_table_id = aws_route_table.nat-rtb[count.index].id
}
