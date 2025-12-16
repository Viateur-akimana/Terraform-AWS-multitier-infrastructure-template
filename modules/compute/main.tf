resource "aws_instance" "nss25" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]
  key_name = "test-server-kp"

  tags = {
    Name = "FirstTFInstance"
  }
}