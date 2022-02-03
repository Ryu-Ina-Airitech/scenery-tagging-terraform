#-------------------------
# VPC
#-------------------------
resource "aws_vpc" "vpc-scenery-tagging" {
  cidr_block                       = "192.168.0.0/20"
  instance_tenancy                 = "default"
  enable_dns_support               = true
  enable_dns_hostnames             = true
  assign_generated_ipv6_cidr_block = false

  tags = {
    Name    = "${var.project}-${var.environment}-vpc"
    Project = var.project
    Env     = var.environment
  }
}

#-------------------------
# Subnet
#-------------------------
resource "aws_subnet" "scenery_tagging_public_subnet_1a" {
  vpc_id                  = aws_vpc.vpc-scenery-tagging.id
  availability_zone       = "us-east-1a"
  cidr_block              = "192.168.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name    = "${var.project}-${var.environment}-public-subnet-1a"
    Project = var.project
    Env     = var.environment
    Type    = "public"
  }
}

resource "aws_subnet" "scenery_tagging_private_subnet_1a" {
  vpc_id                  = aws_vpc.vpc-scenery-tagging.id
  availability_zone       = "us-east-1a"
  cidr_block              = "192.168.2.0/24"
  map_public_ip_on_launch = false

  tags = {
    Name    = "${var.project}-${var.environment}-private-subnet-1a"
    Project = var.project
    Env     = var.environment
    Type    = "private"
  }
}

# resource "aws_subnet" "scenery_tagging_public_subnet_1c" {
#   vpc_id                  = aws_vpc.vpc-scenery-tagging.id
#   availability_zone       = "us-east-1c"
#   cidr_block              = "192.168.3.0/24"
#   map_public_ip_on_launch = true

#   tags = {
#     Name    = "${var.project}-${var.environment}-public-subnet-1c"
#     Project = var.project
#     Env     = var.environment
#     Type    = "public"
#   }
# }

# resource "aws_subnet" "scenery_tagging_private_subnet_1c" {
#   vpc_id                  = aws_vpc.vpc-scenery-tagging.id
#   availability_zone       = "us-east-1c"
#   cidr_block              = "192.168.4.0/24"
#   map_public_ip_on_launch = false

#   tags = {
#     Name    = "${var.project}-${var.environment}-private-subnet-1c"
#     Project = var.project
#     Env     = var.environment
#     Type    = "private"
#   }
# }

#-------------------------
# Route table
#-------------------------
resource "aws_route_table" "scenery-tagging-public-rt" {
  vpc_id = aws_vpc.vpc-scenery-tagging.id

  tags = {
    Name    = "${var.project}-${var.environment}-public-rt"
    Project = var.project
    Env     = var.environment
    Type    = "public"
  }
}

resource "aws_route_table" "scenery-tagging-private-rt" {
  vpc_id = aws_vpc.vpc-scenery-tagging.id

  tags = {
    Name    = "${var.project}-${var.environment}-private-rt"
    Project = var.project
    Env     = var.environment
    Type    = "private"
  }
}

resource "aws_route_table_association" "scenery-tagging-public-rta-1a" {
  route_table_id = aws_route_table.scenery-tagging-public-rt.id
  subnet_id      = aws_subnet.scenery_tagging_public_subnet_1a.id
}

# resource "aws_route_table_association" "scenery-tagging-public-rta-1c" {
#   route_table_id = aws_route_table.scenery-tagging-public-rt.id
#   subnet_id      = aws_subnet.scenery_tagging_public_subnet_1c.id
# }

resource "aws_route_table_association" "scenery-tagging-private-rta-1a" {
  route_table_id = aws_route_table.scenery-tagging-private-rt.id
  subnet_id      = aws_subnet.scenery_tagging_private_subnet_1a.id
}

# resource "aws_route_table_association" "scenery-tagging-private-rta-1c" {
#   route_table_id = aws_route_table.scenery-tagging-private-rt.id
#   subnet_id      = aws_subnet.scenery_tagging_private_subnet_1c.id
# }

#-------------------------
# Internet Gateway
#-------------------------
resource "aws_internet_gateway" "scenery-tagging-internet-gw" {
  vpc_id = aws_vpc.vpc-scenery-tagging.id

  tags = {
    Name    = "${var.project}-${var.environment}-igw"
    Project = var.project
    Env     = var.environment
  }
}

resource "aws_route" "scenery-tagging-rt-igw-r" {
  route_table_id         = aws_route_table.scenery-tagging-public-rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.scenery-tagging-internet-gw.id
}