# Create VPC
resource "aws_vpc" "nss25" {
  cidr_block = var.vpc_cidr

  enable_dns_hostnames = "true"
  enable_dns_support   = "true"
  tags = {
    Name = "nss25_vpc"
  }
}

# Create Public Subnet
resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.nss25.id
  cidr_block        = var.public_subnet_cidr
  availability_zone = var.availability_zone
  map_public_ip_on_launch = true

  tags = {
    Name = "public_subnet"
  }
}

# Create Private Subnet
resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.nss25.id
  cidr_block        = var.private_subnet_cidr
  availability_zone = var.availability_zone

  tags = {
    Name = "private_subnet"
  }
}

# Create Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.nss25.id

  tags = {
    Name = "nss25"
  }
}

# # Attach Internet Gateway to VPC - not needed as vpc_id is specified in aws_internet_gateway
# resource "aws_internet_gateway_attachment" "example" {
#   internet_gateway_id = aws_internet_gateway.igw.id
#   vpc_id              = aws_vpc.nss25.id
# }

# Create Public Route Table
resource "aws_route_table" "nss25_public" {
  vpc_id = aws_vpc.nss25.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "nss25_public_rtb"
  }
}

# Associate Public Subnet with Public Route Table
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.nss25_public.id
}