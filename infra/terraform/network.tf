resource "aws_vpc" "lab" {
  cidr_block           = "10.88.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true


  tags = {
    Name    = "${var.project_name}-vpc"
    Project = var.project_name
  }
}


resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.lab.id
  cidr_block              = "10.88.10.0/24"
  map_public_ip_on_launch = true



  tags = {

    Name    = "${var.project_name}-public-subnet"
    Project = var.project_name

  }
}


resource "aws_internet_gateway" "lab" {

  vpc_id = aws_vpc.lab.id


  tags = {

    Name = "${var.project_name}-igw"

    Project = var.project_name
  }
}

resource "aws_route_table" "table" {
  vpc_id = aws_vpc.lab.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.lab.id

  }
  tags = {
    Name    = "${var.project_name}-public-rt"
    Project = var.project_name
  }
}


resource "aws_route_table" "public" {

  vpc_id = aws_vpc.lab.id

  route {
    cidr_block = "0.0.0.0"
    gateway_id = aws_internet_gateway.lab.id
  }

  tags = {

    Name = "${var.project_name}-public-rt"

    Project = var.project_name

  }
}

































