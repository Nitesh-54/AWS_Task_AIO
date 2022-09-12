#EC2 Creation
resource "aws_instance" "test_ec2" {
	ami               = var.ami_id
	instance_type     = var.instance_type
	subnet_id         = var.public_subnet_id
	availability_zone = var.availability_zone
	tags = {
	Name              = format("test_ec2-%s",var.tag)
	}
}

#Storage
resource "aws_ebs_volume" "demoStore" {
  depends_on          = [aws_instance.test_ec2]
  size                = var.ebs_size
  type                = var.ebs_type
  availability_zone   = aws_instance.test_ec2.availability_zone
}

#Volume Attachment
resource "aws_volume_attachment" "tfebs_aws_task" {
  depends_on          = [aws_ebs_volume.demoStore]
  volume_id           = aws_ebs_volume.demoStore.id
  device_name         = var.ebsDeviceName
  instance_id         = aws_instance.test_ec2.id
}