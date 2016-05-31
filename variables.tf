# aws creds
variable "access_key" {}
variable "secret_key" {}
variable "name" { default = "fleet" }
variable "cidr" { default = "10.0.0.0/16" }
variable "public_subnets" { default = "10.0.101.0/24,10.0.102.0/24,10.0.103.0/24" }
variable "private_subnets" { default = "10.0.1.0/24,10.0.2.0/24,10.0.3.0/24" }
variable "azs" { default = "us-west-2a,us-west-2b,us-west-2c" }
variable "enable_dns_hostnames" { default = true }
variable "enable_dns_support" { default = true }
variable "region" { default = "us-west-2" }
variable "nat_gateways_count" { default = 2 }
