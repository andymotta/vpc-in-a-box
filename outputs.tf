output "private" {
  value = "${
    formatlist(
      "Private Subnet with CIDR %s is in availability zone %s",
      aws_subnet.private.*.cidr_block,
      aws_subnet.private.*.availability_zone
    )}"
}

output "public" {
  value = "${
    formatlist(
      "Public Subnet with CIDR %s is in availability zone %s",
      aws_subnet.public.*.cidr_block,
      aws_subnet.public.*.availability_zone
    )}"
}

output "vpc_id" {
  value = "${aws_vpc.main.id}"
}
