# outputs.tf
# aws-single-node
#
# These are output variables. They provide a convenient way to get 
# useful information from the infrastructure during the runtime of the 
# commands: "terraform plan", "terraform apply" and "terraform output".
#
# Copyright (c) 2022 Eduardo Toro

output "instance_zone" {
  value = aws_instance.ec2_01.availability_zone
}

output "instance_type" {
  value = aws_instance.ec2_01.instance_type
}

output "instance_private_ip" {
  value = aws_instance.ec2_01.private_ip
}

output "instance_public_ip" {
  value = aws_eip.eip_01.public_ip
}
