# aws creds
variable "access_key" {}
variable "secret_key" {}

variable "name" { default = "vpcinabox" }
variable "cidr" { default = "10.10.0.0/16" }

variable "enable_dns_hostnames" { default = true }
variable "enable_dns_support" { default = true }
variable "region" { default = "us-west-2" }
variable "az_count" { default = "3" }
