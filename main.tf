# main.tf
# aws-single-node
#
# Main component of the root module.
# Contains the list of resources to 
# create the infrastructure in aws. 
#
# Copyright (c) 2021 Eduardo Toro

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
  required_version = ">= 1.0.0"
}

provider "aws" {
  region = var.region["uw1"]
}

# Resource tag name arguments created by interpolating 
# the 'resource name'-'environment value'-'name value'
# from global variable "project".
locals {
  vpc_name        = "vpc-${var.project["environment"]}-${var.project["name"]}"
  igw_name        = "igw-${var.project["environment"]}-${var.project["name"]}"
  seg_name        = "seg-${var.project["environment"]}-${var.project["name"]}"
  snt_public_name = "snt-${var.project["environment"]}-${var.project["name"]}"
  rtb_public_name = "rtb-${var.project["environment"]}-${var.project["name"]}"
  nic_public_name = "nic-${var.project["environment"]}-${var.project["name"]}"
  eip_name        = "eip-${var.project["environment"]}-${var.project["name"]}"
}

resource "aws_vpc" "vpc_main" {
  cidr_block       = var.netblock["network"]
  instance_tenancy = "default"

  tags = {
    Name = local.vpc_name
  }
}

resource "aws_internet_gateway" "igw_main" {
  vpc_id = aws_vpc.vpc_main.id

  tags = {
    Name = local.igw_name
  }
}

resource "aws_security_group" "seg_main" {
  vpc_id      = aws_vpc.vpc_main.id
  description = "Allow only SSH, ICMP, TLS inbound traffic from any source"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

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

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = local.seg_name
  }
}

resource "aws_subnet" "snt_public" {
  vpc_id            = aws_vpc.vpc_main.id
  cidr_block        = var.netblock["public"]
  availability_zone = var.region["uw1b"]

  tags = {
    Name = local.snt_public_name
  }
}

resource "aws_route_table" "rtb_public" {
  vpc_id = aws_vpc.vpc_main.id

  route {
    cidr_block = var.netblock["default"]
    gateway_id = aws_internet_gateway.igw_main.id
  }

  tags = {
    Name = local.rtb_public_name
  }
}

# Association between route_table and public_subnet.
resource "aws_route_table_association" "rta_public" {
  subnet_id      = aws_subnet.snt_public.id
  route_table_id = aws_route_table.rtb_public.id
}

resource "aws_network_interface" "nic_public" {
  subnet_id       = aws_subnet.snt_public.id
  security_groups = [aws_security_group.seg_main.id]
  private_ips     = ["10.0.1.101"]

  tags = {
    Name = local.nic_public_name
  }
}

resource "aws_eip" "eip_main" {
  depends_on                = [aws_internet_gateway.igw_main]
  network_interface         = aws_network_interface.nic_public.id
  associate_with_private_ip = "10.0.1.101"
  vpc                       = true

  tags = {
    "Name" = local.eip_name
  }
}

resource "aws_instance" "instance_main" {
  ami               = var.vm3["ami"]
  instance_type     = var.vm3["instance_type"]
  availability_zone = var.vm3["availability_zone"]
  key_name          = var.access_key

  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.nic_public.id
  }

  tags = {
    Name = var.vm3["name"]
  }
}
