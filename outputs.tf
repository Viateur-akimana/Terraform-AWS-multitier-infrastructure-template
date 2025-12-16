# Output EC2 Instance public IP
output "instance_ip" {
  value = module.compute.instance-ip
}