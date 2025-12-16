# Create Security Group for Public Access
resource "aws_security_group" "allow_http_ssh" {
  name        = var.public_security_group_name
  description = "Allow HTTP and SSH inbound traffic and all outbound traffic"
  # reference the VPC created in the networking module
  vpc_id = var.vpc_id

  tags = {
    Name = "allow_http_ssh"
  }
}

# Create Inbound Rule to Allow HTTP Traffic from public IPs
resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.allow_http_ssh.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.allow_http_ssh.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic" {
  security_group_id = aws_security_group.allow_http_ssh.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}