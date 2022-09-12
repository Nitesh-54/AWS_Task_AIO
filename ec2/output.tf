output "instance" {
  value = aws_instance.test_ec2.id
}

output "ebs_volume" {
  value = aws_ebs_volume.demoStore.id
}