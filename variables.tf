# variables.tf
# module aws-single-node
#
# Variable component of the root module. It contains all global variables used 
# by the Main component (main.tf).
#
# Copyright (c) 2023 Eduardo Toro

variable "project" {
  description = "Cloud VM Infrastructure as Code"
  type        = map(string)
  default = {
    tag        = "cloud-vm-shell"
    access_key = "etoromol-cloud-key"
  }
}

variable "region" {
  description = "Dictionary of AWS Availability Zones"
  type        = map(string)
  default = {
    ue1  = "us-east-1"
    ue2  = "us-east-2"
    ue2a = "us-east-2a"
    uw1  = "us-west-1"
    uw2  = "us-west-2"
    uw1b = "us-west-1b"
    uw1c = "us-west-1c"
  }
}

variable "netblock" {
  description = "Network block"
  type        = map(string)
  default = {
    default = "0.0.0.0/0"
    network = "10.0.0.0/16"
    cloud   = "10.0.1.0/24"
  }
}

variable "vm_01" {
  description = "Cisco Catalyst 8000V - BYO with IOS XE 17.4.1b"
  type        = map(any)
  default = {
    "name"              = "cat8000v_17_04_1b"
    "ami"               = "ami-0566d868d1b4458fd"
    "instance_type"     = "t3.medium"
    "availability_zone" = "us-west-1b"
    "key_name"          = ""
  }
}

variable "vm_02" {
  description = "Cisco Catalyst 8000V - BYO with IOS XE 17.05.1a"
  type        = map(any)
  default = {
    "name"              = "cat8000v_17_05_1a"
    "ami"               = "ami-0b09ad6ef5daf67b1"
    "instance_type"     = "t3.medium"
    "availability_zone" = "us-west-1b"
    "key_name"          = ""
  }
}

variable "vm_03" {
  description = "Cisco Catalyst 8000V - BYO with IOS XE 17.06.3a"
  type        = map(any)
  default = {
    "name"              = "cat8000v_17_06_3a"
    "ami"               = "ami-0337c5da21a9f9d28"
    "instance_type"     = "t3.medium"
    "availability_zone" = "us-west-1b"
    "key_name"          = ""
  }
}

variable "vm_04" {
  description = "Cisco Catalyst 8000V - BYO with IOS XE 17.07.1a"
  type        = map(any)
  default = {
    "name"              = "cat8000v_17_07_1a"
    "ami"               = "ami-01a543c6a200d6dcd"
    "instance_type"     = "t3.medium"
    "availability_zone" = "us-west-1b"
    "key_name"          = ""
  }
}

variable "vm_05" {
  description = "Cisco Catalyst 8000V - BYO with IOS XE 17.08.1a"
  type        = map(any)
  default = {
    "name"              = "cat8000v_17_08_1a"
    "ami"               = "ami-0082690930bd41466"
    "instance_type"     = "t3.medium"
    "availability_zone" = "us-west-1b"
    "key_name"          = ""
  }
}

variable "vm_06" {
  description = "Cisco Cloud Services Router 1000V - with IOS XE 17.3.3"
  type        = map(any)
  default = {
    "name"              = "csr1000v_17_3_3"
    "ami"               = "ami-078986d887163741b"
    "instance_type"     = "t2.medium"
    "availability_zone" = "us-west-1b"
    "key_name"          = ""
  }
}

variable "vm_07" {
  description = <<EOT
                Cisco Cloud Services Router 1000V - Security Pkg. Max 
                Performance with IOS XE 16.12.5.
                EOT
  type        = map(any)
  default = {
    "name"              = "csr1000v_16_12_05"
    "ami"               = "ami-0a51195a8716a60e4"
    "instance_type"     = "t2.medium"
    "availability_zone" = "us-west-1b"
    "key_name"          = ""
  }
}

variable "vm_08" {
  description = <<EOT
                Cisco Cloud Services Router 1000V - Security Pkg. Max 
                Performance with IOS XE 16.9.2.
                EOT
  type        = map(any)
  default = {
    "name"              = "csr1000v_16_09_02"
    "ami"               = "ami-02b1bc6d2e4aa01a6"
    "instance_type"     = "t2.medium"
    "availability_zone" = "us-east-2a"
    "key_name"          = ""
  }
}

variable "vm_09" {
  description = "Red Hat Enterprise Linux 8 (HVM), SSD Volume Type"
  type        = map(any)
  default = {
    "name"              = "rhel_8"
    "ami"               = "ami-054965c6cd7c6e462"
    "instance_type"     = "t2.micro"
    "availability_zone" = "us-west-1b"
    "key_name"          = ""
  }
}

variable "vm_10" {
  description = "Ubuntu Server 20.04 LTS (HVM), SSD Volume Type"
  type        = map(any)
  default = {
    "name"              = "ubuntu_20_04"
    "ami"               = "ami-0d382e80be7ffdae5"
    "instance_type"     = "t2.micro"
    "availability_zone" = "us-west-1b"
    "key_name"          = ""
  }
}

variable "vm_11" {
  description = "Microsoft Windows Server 2012 R2 Base"
  type        = map(any)
  default = {
    "name"              = "windows_2012_r2"
    "ami"               = "ami-0c980234db5b91d44"
    "instance_type"     = "t2.micro"
    "availability_zone" = "us-west-1b"
    "key_name"          = ""
  }
}

variable "vm_12" {
  description = "Microsoft Windows Server 2016 Base"
  type        = map(any)
  default = {
    "name"              = "windows_2016"
    "ami"               = "ami-0807f3d00dc7f1d6e"
    "instance_type"     = "t2.micro"
    "availability_zone" = "us-west-1b"
    "key_name"          = ""
  }
}

variable "vm_13" {
  description = "Microsoft Windows Server 2019 Base"
  type        = map(any)
  default = {
    "name"              = "windows_2019"
    "ami"               = "ami-0c645579c7f157046"
    "instance_type"     = "t2.micro"
    "availability_zone" = "us-west-1b"
    "key_name"          = ""
  }
}

variable "vm_14" {
  description = "Amazon Linux 2"
  type        = map(any)
  default = {
    "name"              = "aws_linux_2"
    "ami"               = "ami-0ed05376b59b90e46"
    "instance_type"     = "t2.micro"
    "availability_zone" = "us-west-1b"
    "key_name"          = ""
  }
}

variable "vm_15" {
  description = "Microsoft Windows Server 2022 Base"
  type        = map(any)
  default = {
    "name"              = "windows_2022"
    "ami"               = "ami-031b64cec4b201110"
    "instance_type"     = "t2.micro"
    "availability_zone" = "us-west-1b"
    "key_name"          = ""
  }
}
