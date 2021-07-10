# outputs.tf
# aws-single-node
#
# Output variables that display information 
# from the ec2-instance created. 
#
# Copyright (c) 2021 Eduardo Toro

output "instance-zone" {
  value = aws_instance.instance_main_1.availability_zone
}

output "instance-type" {
  value = aws_instance.instance_main_1.instance_type
}

output "instance-private_ip" {
  value = aws_instance.instance_main_1.private_ip
}

output "instance-public_ip" {
  value = aws_instance.instance_main_1.public_ip
}
