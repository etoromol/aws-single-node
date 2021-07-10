# outputs.tf
# aws-single-node
#
# Output variables that display information 
# from the ec2-instance created. 
#
# Copyright (c) 2021 Eduardo Toro

output "instance-zone" {
  value = aws_instance.instance_main.availability_zone
}

output "instance-type" {
  value = aws_instance.instance_main.instance_type
}

output "instance-private_ip" {
  value = aws_instance.instance_main.private_ip
}

output "instance-public_ip" {
  value = aws_instance.instance_main.public_ip
}
