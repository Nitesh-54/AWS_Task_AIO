module "vpc" {
   source                    = "./vpc"
   vpc_cidr                  = var.vpc_cidr
   public_subnet_cidr        = var.public_subnet_cidr
   private_subnet_cidr       = var.private_subnet_cidr
   availability_zone         = var.availability_zone
   Instance_tenancy          = var.Instance_tenancy
   tag                       = var.tag
   map_public_ip_private     = var.map_public_ip_private
   map_public_ip_public      = var.map_public_ip_public
   INT_GW_RT_cidr_range      = var.INT_GW_RT_cidr_range
   NAT_RT_cidr               = var.NAT_RT_cidr
}

module "securitygroup" {
   depends_on                = [module.vpc]
   source                    = "./securitygroup"
   security_group_name       = var.security_group_name
   TestVPC_id                = module.vpc.vpc_id
   tag                       = format("TestSG-%s", var.tag)
}

module "ec2" {
   source                    = "./ec2"
   depends_on                = [module.vpc]
   ami_id                    = var.ami_id
   instance_type             = var.instance_type
   tag                       = var.tag
   ebs_size                  = var.ebs_size
   ebs_type                  = var.ebs_type
   public_subnet_id          = module.vpc.public_subnet_id
   availability_zone         = var.availability_zone
   ebsDeviceName             = var.ebsDeviceName
}