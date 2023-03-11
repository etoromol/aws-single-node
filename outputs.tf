# outputs.tf
# module aws-single-node
#
# These are output variables. They provide a convenient way to get useful data 
# from the infrastructure during the runtime of the cli commands: 
# "terraform plan", "terraform apply" and "terraform output".
#
# Copyright (c) 2023 Eduardo Toro

output "vm-zone" {
  value = aws_instance.ec2_01.availability_zone
}

output "vm-tier" {
  value = aws_instance.ec2_01.instance_type
}

output "vm-privte-ip" {
  value = aws_instance.ec2_01.private_ip
}

output "vm-public-ip" {
  value = aws_eip.eip_01.public_ip
}