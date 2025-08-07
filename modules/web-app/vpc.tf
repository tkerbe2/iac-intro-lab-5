#                     _    __ 
#                    | |  / _|
#  __   ___ __   ___ | |_| |_ 
#  \ \ / / '_ \ / __|| __|  _|
#   \ V /| |_) | (__ | |_| |  
#    \_/ | .__/ \___(_)__|_|  
#        | |                  
#        |_|                  

#==============#
# VPC Resource #
#==============#


resource "aws_vpc" "lab_vpc" {
  cidr_block       = var.cidr_block
  instance_tenancy = "default"

  tags = {

    Name        = "${local.name_prefix}-vpc"
    Environment = var.env
  }
}

#=================#
# Subnet Resource #
#=================#


resource "aws_subnet" "lab_web_sn" {
count = length(local.availability_zones)

  vpc_id     = aws_vpc.lab_vpc.id
  cidr_block = cidrsubnet(var.cidr_block, var.borrowed_bits, count.index)
  availability_zone = local.availability_zones[count.index]
  tags = {
    Name        = "${local.name_prefix}-${count.index + 1}-web"
    Environment = var.env
  }
}

#==================#
# Internet Gateway #
#==================#

resource "aws_internet_gateway" "lab_igw" {
  vpc_id = aws_vpc.lab_vpc.id

  tags = {
    Name        = "${local.name_prefix}-web-igw"
    Environment = var.env
  }
}

#=====================#
# Default Route Table #
#=====================#

resource "aws_default_route_table" "lab_default_rt" {
  default_route_table_id = aws_vpc.lab_vpc.default_route_table_id

    route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.lab_igw.id
    }

  tags = {
    Name        = "${local.name_prefix}-web-sn"
    Environment = var.env
  }
}

#=========================#
# Route Table Association #
#=========================#
resource "aws_route_table_association" "rta" {
  count          = length(local.availability_zones)
  subnet_id      = aws_subnet.lab_web_sn[count.index].id
  route_table_id = aws_default_route_table.lab_default_rt.id
}
