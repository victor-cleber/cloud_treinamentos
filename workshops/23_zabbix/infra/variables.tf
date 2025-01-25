variable "region" {
  type        = string
  description = "AWS region where the infrastructure will be created"
  default     = "us-east-1"
  #default    = "ap-southeast-2"
}

variable "vpc_name" {
  type        = string
  description = "AWS vpc name"
  default     = "workshop_23_zabbix"
}

variable "vpc_cidr" {
  type    = string
  default = "100.64.0.0/16"
}

variable "workshop_edition" {
  type    = string
  default = "workshop_23"
}

variable "author" {
  type    = string
  default = "Victor Cleber"
}

variable "group" {
  type    = string
  default = "Group 7"
}

variable "managed_by" {
  type    = string
  default = "terraform"
}

variable "subject" {
  type    = string
  default = "Zabbix"
}

variable "course" {
  type    = string
  default = "Cloud Training - AWS bootcamp"
}

variable "availability_zones" {
  description = "Availability zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}


variable "ec2_instance_name" {
  description = "EC2 instance name"
  type        = string
  default     = "Zabbix_server"
}

#key pair - Location to the SSH Key generate using openssl or ssh-keygen or AWS KeyPair
variable "ssh_pubkey_file" {
  description = "Path to an SSH public key"
  default     = "./ec2_rsa.pub"
}

variable "user_name" {
  description = "Zabbix DB username"
  default = "admin-zabbix"
}