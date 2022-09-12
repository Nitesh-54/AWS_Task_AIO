variable "ami_id"{
    type = string
}

variable "instance_type"{
    type = string
}

variable "public_subnet_id"{
    type = string
}

variable "ebs_size" {
  type = number
}

variable "ebs_type" {
  type = string
}

variable "tag"{
    type = string
}

variable "ebsDeviceName"{
    type = string
}

variable "availability_zone"{
    type = string
}