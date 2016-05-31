provider "aws" {
    access_key = "${var.access_key}"
    secret_key = "${var.secret_key}"
    region     = "${var.region}"
}

resource "aws_vpc" "mod" {
  cidr_block = "${var.cidr}"
  enable_dns_hostnames = "${var.enable_dns_hostnames}"
  enable_dns_support = "${var.enable_dns_support}"
  tags { Name = "${var.name}" }
}

resource "aws_internet_gateway" "mod" {
  vpc_id = "${aws_vpc.mod.id}"
}

resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.mod.id}"
  count  = "${length(split(",", var.public_subnets))}"
  tags {
    Name = "${var.name}.public.${element(split(",", var.azs), count.index)}"
  }
}

resource "aws_route" "public_internet_gateway" {
    route_table_id = "${element(aws_route_table.public.*.id, count.index)}"
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.mod.id}"
}

resource "aws_route_table" "private" {
  vpc_id = "${aws_vpc.mod.id}"
  count  = "${length(split(",", var.private_subnets))}"
  tags {
    Name = "${var.name}.private.${element(split(",", var.azs), count.index)}"
  }
}

resource "aws_subnet" "private" {
  vpc_id                  = "${aws_vpc.mod.id}"
  cidr_block              = "${element(split(",", var.private_subnets), count.index)}"
  availability_zone       = "${element(split(",", var.azs), count.index)}"
  count                   = "${length(split(",", var.private_subnets))}"
  tags {
    Name = "${var.name}.private.${element(split(",", var.azs), count.index)}"
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = "${aws_vpc.mod.id}"
  cidr_block              = "${element(split(",", var.public_subnets), count.index)}"
  availability_zone       = "${element(split(",", var.azs), count.index)}"
  count                   = "${length(split(",", var.public_subnets))}"
  map_public_ip_on_launch = true
  tags {
    Name = "${var.name}.public.${element(split(",", var.azs), count.index)}"
  }
}

resource "aws_route_table_association" "private" {
  subnet_id      = "${element(aws_subnet.private.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.private.*.id, count.index)}"
  count          = "${length(split(",", var.private_subnets))}"
}

resource "aws_route_table_association" "public" {
  subnet_id      = "${element(aws_subnet.public.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.public.*.id, count.index)}"
  count          = "${length(split(",", var.public_subnets))}"
}

#nat gateway
resource "aws_route" "nat_gateway" {
  route_table_id         = "${element(aws_route_table.private.*.id, count.index)}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${element(aws_nat_gateway.nat.*.id, count.index)}"
  count                  = "${length(split(",", var.private_subnets))}"
  depends_on             = ["aws_route_table.private"]
}

resource "aws_eip" "nat" {
  count = "${var.nat_gateways_count}"
  vpc = true
}

resource "aws_nat_gateway" "nat" {
  allocation_id = "${element(aws_eip.nat.*.id, count.index)}"
  subnet_id = "${element(aws_subnet.public.*.id, count.index)}"
  count = "${var.nat_gateways_count}"
}
