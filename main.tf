module "vpc" {
   source                    = "./vpc"
   vpc_cidr                  = "10.0.0.0/24"
   public_subnet_cidr        = "10.0.0.0/25"
   private_subnet_cidr       = "10.0.0.128/25"
   availability_zone         = "us-east-1a"
   Instance_tenancy          = "default"
   tag                       = "aws"
   map_public_ip_private     = "false"
   map_public_ip_public      = "true"
   INT_GW_RT_cidr_range      = "0.0.0.0/0"
   NAT_RT_cidr               = "0.0.0.0/0"
}

module "securitygroup" {
   depends_on                = [module.vpc]
   source                    = "./securitygroup"
   security_group_name       = "TestSG"
   TestVPC_id                = module.vpc.vpc_id
   tag                       = format("TestSG-%s", "aws")
}

module "ec2" {
   source                    = "./ec2"
   depends_on                = [module.vpc]
   ami_id                    = "ami-0c95d38b24a19de18"
   instance_type             = "t2.micro"
   tag                       = "aws"
   ebs_size                  = "8"
   ebs_type                  = "gp3"
   public_subnet_id          = module.vpc.public_subnet_id
   availability_zone         = "us-east-1a"
   ebsDeviceName             = "/dev/xvda"
}