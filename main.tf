# main.tf
# aws-single-node
#
# Main component of the root module. Contain a list of local variables, 
# providers and resources to create the infrastructure in aws. 
#
# Copyright (c) 2022 Eduardo Toro

locals {
  vpc_01 = "vpc_01-${var.project}"
  igw_01 = "igw_01-${var.project}"
  seg_01 = "seg_01-${var.project}"
  snt_01 = "snt_01-${var.project}"
  rtb_01 = "rtb_01-${var.project}"
  nic_01 = "nic_01-${var.project}"
  eip_01 = "eip_01-${var.project}"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.75.1"
    }
  }
  required_version = "1.2.4"
}

provider "aws" {
  region = var.region["uw1"]
}

resource "aws_vpc" "vpc_01" {
  cidr_block       = var.netblock["network"]
  instance_tenancy = "default"
  tags = {
    Name = local.vpc_01
  }
}

resource "aws_internet_gateway" "igw_01" {
  vpc_id = aws_vpc.vpc_01.id
  tags = {
    Name = local.igw_01
  }
}

resource "aws_security_group" "seg_01" {
  vpc_id      = aws_vpc.vpc_01.id
  description = "Permit SSH, ICMP, TLS inbound traffic from any source"
  ingress {
    description = "ICMP"
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "TLS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = local.seg_01
  }
}

resource "aws_subnet" "snt_01" {
  vpc_id            = aws_vpc.vpc_01.id
  cidr_block        = var.netblock["public"]
  availability_zone = var.region["uw1b"]
  tags = {
    Name = local.snt_01
  }
}

resource "aws_route_table" "rtb_01" {
  vpc_id = aws_vpc.vpc_01.id
  route {
    cidr_block = var.netblock["default"]
    gateway_id = aws_internet_gateway.igw_01.id
  }
  tags = {
    Name = local.rtb_01
  }
}

resource "aws_route_table_association" "ass_01" {
  subnet_id      = aws_subnet.snt_01.id
  route_table_id = aws_route_table.rtb_01.id
}

resource "aws_network_interface" "nic_01" {
  subnet_id       = aws_subnet.snt_01.id
  security_groups = [aws_security_group.seg_01.id]
  private_ips     = ["10.0.1.117"]
  tags = {
    Name = local.nic_01
  }
}

resource "aws_eip" "eip_01" {
  depends_on                = [aws_internet_gateway.igw_01]
  instance                  = aws_instance.ec2_01.id
  associate_with_private_ip = "10.0.1.117"
  vpc                       = true
  tags = {
    "Name" = local.eip_01
  }
}

resource "aws_instance" "ec2_01" {
  ami               = var.vm_03["ami"]
  instance_type     = var.vm_03["instance_type"]
  availability_zone = var.vm_03["availability_zone"]
  key_name          = var.access_key
  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.nic_01.id
  }
  tags = {
    Name = var.vm_03["name"]
  }
}
