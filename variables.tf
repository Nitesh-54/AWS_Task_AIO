variable "vpc_cidr" {
  type = string
}

variable "public_subnet_cidr" {
  type = string
}

variable "private_subnet_cidr" {
  type = string
}

variable "availability_zone" {
  type = string
}

variable "Instance_tenancy" {
  type = string
}

variable "tag" {
  type = string
}

variable "map_public_ip_private" {
  type = string
}

variable "map_public_ip_public" {
  type = string
}

variable "INT_GW_RT_cidr_range" {
  type = string
}

variable "NAT_RT_cidr" {
  type = string
}

variable "security_group_name" {
  type = string
}

variable "ami_id" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "ebs_size" {
  type = string
}

variable "ebs_type" {
  type = string
}

variable "ebsDeviceName" {
  type = string
}