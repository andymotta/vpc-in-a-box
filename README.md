vpc-in-a-box
=========

This will create a VPC, public subnets in x AZs with an internet gw, x private subnets in x AZs with Nat Gateway and x route tables for x private subnets.


How to use
------------

* Copy terraform.tfvars.EDITME to terraform.tfvars and enter AWS creds
* Check variables to change defaults
* terraform plan
* if terraform plan passes run terraform apply


Module Variables
--------------

Most important variables to change are:
```
variable "name" { default = "fleet" }
variable "cidr" { default = "10.0.0.0/16" }
```
**name** with precede all resources created with tags
**cidr** is t he VPC block you are splitting

Module defaults
--------------

3 AZs with the following CIDRs:
```
private = [
    Private Subnet with CIDR 10.10.3.0/24 is in availability zone us-west-2a,
    Private Subnet with CIDR 10.10.4.0/24 is in availability zone us-west-2b,
    Private Subnet with CIDR 10.10.5.0/24 is in availability zone us-west-2c
]
public = [
    Public Subnet with CIDR 10.10.0.0/24 is in availability zone us-west-2a,
    Public Subnet with CIDR 10.10.1.0/24 is in availability zone us-west-2b,
    Public Subnet with CIDR 10.10.2.0/24 is in availability zone us-west-2c
]
```

Module Reference Example
----------------

```
```

Roadmap
----------------
- Allow Adding Network ACL

License
-------

MIT

Author Information
------------------

@andymotta
