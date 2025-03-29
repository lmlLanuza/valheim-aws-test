variable "region" {
  description = "AWS Region to deploy the resources."
  type        = string
  default     = "ap-southeast-1"
}

variable "availability_zone" {
  description = "AWS Availability Zone to deploy the resources."
  type        = string
  default     = "ap-southeast-1c"
}

variable "instance_type" {
  description = "EC2 instance type."
  type        = string
  default     = "t3a.medium"
}

variable "volume_type" {
  description = "value type of the root block device."
  type        = string
  default = "gp3"
}

variable "volume_size" {
  description = "Size of the root block device."
  type        = number
  default = 12
  
}

variable "valheim_server_name" {
  description = "Name of the Valheim server."
  type        = string
  default     = "ValheimServer"
}

variable "valheim_ami_owner" {
  description = "Owner of the AMI used for the EC2"
  type        = string
  default     = "self" # Change this to "099720109477" for the Base Ubuntu Image
}

variable "valheim_ami_name" {
  description = "The name of the AMI to be used for the EC2"
  type        = string
  default     = "ValheimServerV4-20250210" # Change this to "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*" for the Base Ubuntu Image
}

variable "keypair_name" {
  description = "Name of the keypair to use for the EC2 instance."
  type        = string
  default = "terraform-valheim-keypair"
}

variable "keypair_public_key" {
  description = "Public key of the keypair to use for the EC2 instance."
  type        = string
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCwTGPNvIFqLkg8oFDCHemKewFhbaJvrQrH199UhYAqa7Sj21nm383rpe6oMpIQeew2G3ODNJynLt8F9Cbe4iZ7mBgwpRx0jOwC1IHNM8z2TdvaZ86CSoQWL3mr73OIo/5MGRRnB8vcHWuixABg8bH+q7EiuuLTna1P5MH6UcM8hxn66slwOuAuc8fbKlBkAuYEAxGo1ASQahmhcktP4ZNPRpbsb68OM1BkvlInDcP5ksUTjE1zZepO8ClwrBVWDZJlrwwn0Yzg080+PrwEpxyQylAyxbj1atEOYAqp1M82Dlp73IUzegKmvBW6Wqhlh4UWmsfdLYMdBE5B3agF0CQ+2cVZZ9oxuposXbyQPW41X9lmUtA2k8mxTsGCXi+8+E8Lali5DmGi2gql+c3huH8NLxEnVy4BG2xpaD9G2NkIx7W3lXVY/48wmIAZsnTxReCxmCJjAeeNmMTAayzgiH36lFlMve+24IGIMHNu+UH6SXMPjgTwZ/zW2latuX6aXHMPQTD9u2loicoGqCAiaBWmTWEXLaPzqpxq4bDluQTMvMhzGaSi8OXilxaAot2n53FycbToX+wCOF83uyCE9/1UXRSKAJL1MKCiY0VY+eKdp7UjwpD9BeThBtmaFg8dd5T9RF+qSvZcpMHHPU8OiD7CO3JiX+3JG8UC9gt5bYOuCQ== terraform valheim ec2 keypair"
  
}

variable "iam_instance_profile_name" {
  description = "Name of the IAM instance profile to use for the EC2 instance."
  type        = string
  default = "valheim_server"
  
}

variable "backup_s3_bucket" {
  description = "S3 bucket name for backups."
  type        = string
  default     = "terraform-valheim-llanuza-v1"
}
