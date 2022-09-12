variable "vpc_cidr"{
    type = string
}

variable "Instance_tenancy"{
    type = string
}

variable "tag"{
    type = string
}

variable "public_subnet_cidr"{
    type = string
}

variable "availability_zone"{
    type = string
}

variable "map_public_ip_public"{
    type = bool
}

variable "INT_GW_RT_cidr_range"{
    type = string
}

variable "private_subnet_cidr"{
    type = string
}

variable "map_public_ip_private"{
    type = bool
}

variable "NAT_RT_cidr"{
    type = string
}