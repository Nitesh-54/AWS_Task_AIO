#security group creation
resource "aws_security_group" "TestSG" {
  description         = "This is a Security group for testing purpose."
  vpc_id              = var.TestVPC_id
  tags                = {
    Name              = format("TestSG-%s", var.tag)
  }

  ingress {
    from_port        = 3389
    to_port          = 3389
    protocol         = "TCP"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}