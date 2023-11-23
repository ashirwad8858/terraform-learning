
resource "aws_vpc" "my_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "MyVPC"
  }
}

resource "aws_subnet" "subnets" {
  count = length(data.aws_availability_zones.available.names)

  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.${count.index + 1}.0/24"
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = count.index % 2 == 0  # Every other subnet is public

  tags = {
    Name = "Subnet-${count.index + 1}"
  }
}

resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "MyInternetGateway"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }

  tags = {
    Name = "PublicRouteTable"
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "PrivateRouteTable"
  }
}

resource "aws_route_table_association" "subnet_associations" {
  count = length(data.aws_availability_zones.available.names)

  subnet_id      = aws_subnet.subnets[count.index].id
  route_table_id = count.index % 2 == 0 ? aws_route_table.public_route_table.id : aws_route_table.private_route_table.id
}

resource "aws_instance" "my_instance" {
  count = length(data.aws_availability_zones.available.names)

  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.subnets[count.index].id

  tags = {
    Name = "Instance-${count.index + 1}"
  }
}

data "aws_availability_zones" "available" {}

