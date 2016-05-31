output "private_subnets" {
  value = "${join(",", aws_subnet.private.*.id)}"
}

output "public_subnets" {
  value = "${join(",", aws_subnet.public.*.id)}"
}

output "vpc_id" {
  value = "${aws_vpc.mod.id}"
}

output "public_route_table_ids" {
  value = "${join(",", aws_route_table.public.*.id)}"
}

output "private_route_table_ids" {
  value = "${join(",", aws_route_table.private.*.id)}"
}

output "nat_eips" {
  value = "${join(",", aws_eip.nat.*.public_ip)}"
}
